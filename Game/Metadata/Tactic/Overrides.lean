import Verbose.English.All

/-! # Game-side refinements of Verbose phrases (round 2 of UX testing)

These re-declare a few Verbose phrases with `(priority := high)`, so the parser prefers the
versions below, and delegate to Verbose's own elaborators after a small adjustment:

* `Assume that _` names the new assumption after the actual hypothesis (`hPQ`) instead of `h`.
* `Let's prove by induction that _` / `Let's prove by induction H : _` take the statement from
  the current goal.
* `We proceed using s` also works for `s : A ⊕ B` (data), giving one goal per summand, in the
  same shape as for `h : P ∨ Q`.
* `We conclude by h` explains what to do instead when `h` is a disjunction, a sum, an
  implication/function whose conclusion is the goal, or a conjunction/pair/existential. -/

open Lean Meta Elab Tactic Verbose Verbose.English

/-- The domain of the goal if it is an implication / ∀ / function type. -/
private def goalDomain? : TacticM (Option Expr) := withMainContext do
  let tgt ← whnf (← getMainTarget)
  return if tgt.isForall then some tgt.bindingDomain! else none

private def isHole (t : Term) : Bool := t.raw.isOfKind ``Lean.Parser.Term.hole

-- `Assume that _`: name from the real hypothesis.
elab (name := gameAssumeThat) (priority := high) "Assume that " t:term : tactic => withMainContext do
  if isHole t then
    let some dom ← goalDomain? | throwError ← noHypIntro
    let domT ← PrettyPrinter.delab dom
    let name ← mk_hyp_name domT dom
    Assume1 (introduced.typed (mkNullNode #[t]) name domT)
  else
    let e ← elabTerm t none
    let name ← mk_hyp_name t e
    Assume1 (introduced.typed (mkNullNode #[t]) name t)

-- Induction with the statement taken from the goal.
private def inductionStmt (stmt : Term) : TacticM Term := withMainContext do
  if isHole stmt then PrettyPrinter.delab (← instantiateMVars (← getMainTarget)) else pure stmt

elab (name := gameInductionThat) (priority := high) "Let's" " prove by induction that " stmt:term : tactic => do
  letsInduct none (← inductionStmt stmt)

elab (name := gameInductionNamed) (priority := high) "Let's" " prove by induction" name:ident ":" stmt:term : tactic => do
  letsInduct name.getId (← inductionStmt stmt)

-- `We proceed using s` for sums as well as disjunctions.
elab (name := gameProceedUsing) (priority := high) "We" " proceed using " e:term : tactic => withMainContext do
  try discussOr e
  catch err =>
    let ty ← whnf (← inferType (← elabTerm e none))
    if ty.isAppOfArity ``Sum 2 then
      evalTactic (← `(tactic| refine Sum.elim ?_ ?_ $e))
    else throw err

-- `We conclude by h` with guidance when `h` is not something one concludes by.
elab (name := gameConcludeBy) (priority := high) "We" " conclude by " e:maybeApplied : tactic => withMainContext do
  let t ← maybeAppliedToTerm e
  try concludeTac t
  catch err =>
    let goal ← getMainTarget
    let hint? : Option MessageData ← (do
      let `($x:ident) := t | return none
      let some decl := (← getLCtx).findFromUserName? x.getId | return none
      let ty ← whnf decl.type
      let name := x.getId
      if ty.isAppOfArity ``Or 2 ∨ ty.isAppOfArity ``Sum 2 then
        return some m!"`{name}` gives you one of two possibilities, so it cannot be used to conclude directly. Write `We proceed using {name}` to treat each possibility in turn."
      if ty.isAppOfArity ``And 2 ∨ ty.isAppOfArity ``Prod 2 ∨ ty.isAppOfArity ``Exists 2 ∨ ty.isAppOfArity ``Iff 2 then
        return some m!"`{name}` bundles several pieces of information. Write `By {name} we get …` naming its parts first."
      if ty.isForall then
        let concl := ty.bindingBody!
        if !concl.hasLooseBVars ∧ (← isDefEq concl goal) then
          return some m!"`{name}` has the goal as its conclusion but needs an input first. Write `We apply {name}` to reduce the goal to that input, or `We conclude by {name} applied to …` if you already have it."
        return some m!"`{name}` is a function or implication; `We conclude by {name}` only works when its type is exactly the goal. Try `We apply {name}` or `We conclude by {name} applied to …`."
      return none)
    match hint? with
    | some h => throwError m!"{err.toMessageData}\n{h}"
    | none => throw err

-- `Set x : A := e`: Verbose's version (`define` + `rewrite … at *` + an `x_def` hypothesis) leaves
-- a `sorry` behind on some data goals and clutters the context; the original game used Lean's
-- `let`, which does exactly what the levels need.
elab (name := gameSet) (priority := high) "Set " n:maybeTypedIdent " := " val:term : tactic => do
  let (name, ty?) := toMaybeTypedIdent n
  let nId := mkIdent name
  match ty? with
  | some ty => evalTactic (← `(tactic| let $nId:ident : $ty := $val))
  | none => evalTactic (← `(tactic| let $nId:ident := $val))
