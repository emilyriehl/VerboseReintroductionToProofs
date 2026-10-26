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

/-- Verbose's `letsInduct` without its `simp_rw [Nat.zero_eq]` / `simp_rw [Nat.succ_eq_add_one]`
post-processing: on Lean ≥ 4.9 the goals already use `0` and `n + 1`, and `simp_rw` closes a trivial
base case such as `0 + 0 = 0`, after which Verbose's `on_goal 3` fails with "No goals to be solved". -/
private def gameLetsInduct (hyp_name? : Option Name) (stmt : Term) : TacticM Unit := do
  let orig_goal ← getMainGoal
  orig_goal.withContext do
  let stmt_expr ← elabTerm stmt none
  let hyp_name ← if let some hyp_name := hyp_name? then
      checkName hyp_name
      pure hyp_name
    else
      mk_hyp_name stmt stmt_expr
  let .forallE bn bt body .. := stmt_expr |
    throwError ← inductionError
  if not (← isDefEq bt (mkConst ``Nat)) then
    throwError ← inductionError
  -- Is the goal a specialization of the announced statement?
  let argMVar ← mkFreshExprMVar (some <| .const `Nat [])
  let arg? ←
    if ← isDefEq (body.instantiate1 argMVar) (← orig_goal.getType >>= instantiateMVars) then
      getExprMVarAssignment? argMVar.mvarId!
    else
      pure none
  let (subGoal, mainGoal, _) ← claim' orig_goal hyp_name stmt_expr
  subGoal.withContext do
    let (n_fvar, newest_goal) ← subGoal.intro1P
    let goals ← newest_goal.induction n_fvar ``Nat.rec #[{varNames := []}, {varNames := [bn, `hyp_rec]}]
    let #[base_subgoal, ind_subgoal] := goals | throwError "Inductive proof failed"
    let (_, ind_case) ← ind_subgoal.mvarId.revert (goals[1]!.fields.map Expr.fvarId!)
    replaceMainGoal [base_subgoal.mvarId, ind_case, mainGoal]
    if let some arg := arg? then
      evalTactic (← `(tactic| on_goal 3 => exact $(mkIdent hyp_name) _))
      if let some argFVar := arg.fvarId? then
        let argName ← argFVar.getUserName
        evalTactic (← `(tactic|
          (on_goal 1 => clear! $(mkIdent argName)
           on_goal 2 => clear! $(mkIdent argName))))
    else
      evalTactic (← `(tactic| on_goal 3 => try (exact $(mkIdent hyp_name))))

elab (name := gameInductionThat) (priority := high) "Let's" " prove by induction that " stmt:term : tactic => do
  gameLetsInduct none (← inductionStmt stmt)

elab (name := gameInductionNamed) (priority := high) "Let's" " prove by induction" name:ident ":" stmt:term : tactic => do
  gameLetsInduct name.getId (← inductionStmt stmt)

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

section RewriteAndCompute
open Lean.Parser.Tactic

/-! ## Rewriting without the automatic `rfl`

Verbose's `We rewrite using h` finishes with `try (with_reducible rfl)`, so it sometimes closes the
goal and sometimes leaves `a = a` open, depending on transparency details players cannot see. The
original game's `rw` works exactly like `rewrite` for the same reason; here too, every goal is
closed explicitly with `We conclude by rfl`. Everything else (`at h`, `everywhere`,
`which becomes …`) is as in Verbose. -/

private def gameRewriteTac (rw : Syntax) (s : TSyntax `myRwRuleSeq) (loc : Option Location)
    (new : Option Term) : TacticM Unit := withMainContext do
  let l ← loc.mapM (fun l => unexpandLocation l)
  let tac : TSyntax `tactic ← match s with
  | `(myRwRuleSeq| [%$lbrak $rs:rwRule,* ]) => `(tactic| rewrite%$rw [%$lbrak $rs,*] $(l)?)
  | `(myRwRuleSeq| $rs:rwRule) => `(tactic| rewrite%$rw [$rs] $(l)?)
  | _ => throwError ""
  evalTactic tac
  if let some t := new then
    let goal ← getMainGoal <|> throwError ← rwResultWithoutGoal
    goal.withContext do
    let fvarId? : Option FVarId ← (do
      match loc with
      | some (.targets #[stx] false) => return some (← getFVarId stx)
      | some (.targets #[] true) => return none
      | none => return none
      | _ => throwError ← rwResultSeveralLoc)
    match fvarId? with
    | some fvarId =>
        let newExpr ← fvarId.getType
        let actualNew ← elabTermEnsuringValue t (← instantiateMVars newExpr)
        replaceMainGoal [← goal.changeLocalDecl fvarId actualNew]
    | none =>
        let tgt ← instantiateMVars (← goal.getType)
        let actualNew ← elabTermEnsuringValue t tgt
        replaceMainGoal [← goal.change actualNew]

elab (name := gameRewrite) (priority := high) rw:"We" " rewrite using " s:myRwRuleSeq l:(location)? new:(becomesEN)? : tactic => do
  gameRewriteTac rw s (l.map expandLocation) (new.map extractBecomes)

elab (name := gameRewriteEverywhere) (priority := high) rw:"We" " rewrite using " s:myRwRuleSeq " everywhere" : tactic => do
  gameRewriteTac rw s (some Location.wildcard) none

/-! ## `We compute` on conjunctions

Verbose's `We compute` handles one equation. Several of the game's statements are conjunctions of
equations between numerals (NaturalNumbersWorld L01, L02), so here `We compute` first splits
conjunctions and then computes each part; the error names the first part that does not follow
from a computation. -/

elab (name := gameCompute) (priority := high) "We" " compute" loc:(location)? : tactic => do
  if loc.isSome then
    computeTac loc
  else
    evalTactic (← `(tactic| repeat' apply And.intro))
    let goals ← getGoals
    for g in goals do
      setGoals [g]
      computeTac none
    setGoals []

end RewriteAndCompute
