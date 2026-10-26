import Verbose.English.All

/-! # Case analysis on inductive data, Verbose style (prototype after UX round 2)

    Let's consider all cases for b                       -- split; every case is "blocked"
    Let's first consider the case where b is false       -- (also splits if not done yet)
    Let's next consider the case where b is true
    Let's consider all cases for s                       -- s : A ⊕ B
    Let's first consider the case where s is inl a       -- names the component `a`
    Let's next consider the case where s is inr b
    Let's define it by recursion on n                    -- n : ℕ, goal is a type
    Let's first consider the case where n is zero
    Let's next consider the case where n is succ k       -- then `Fix r : C k` for the recursive value

Cases may be taken in any order. Until a case is announced, its goal displays as
"You need to announce: Let's consider the case where s is inl val", in the spirit of Verbose's
`goalBlocker` for `Let's first prove that`. -/

open Lean Meta Elab Tactic

universe u

/-- A goal waiting to be announced. `descr` is "x is ctor field₁ field₂…". -/
structure CaseBlocker (descr : String) (α : Sort u) where
  val : α

syntax "You need to announce: Let's consider the case where " ident " is " ident* : term

open PrettyPrinter Delaborator SubExpr in
@[delab app.CaseBlocker]
def delabCaseBlocker : Delab := do
  let e ← getExpr
  guard (e.getAppNumArgs == 2)
  let Expr.lit (.strVal descr) := e.getArg! 0 | failure
  let words := (descr.splitOn " ").filter (· ≠ "")
  let x :: "is" :: rest := words | failure
  let xId := mkIdent (.mkSimple x)
  let restIds := rest.toArray.map (mkIdent <| .mkSimple ·)
  `(You need to announce: Let's consider the case where $xId is $restIds*)

private def ctorFieldNames (ctorName : Name) : MetaM (List String) := do
  let info ← getConstInfoCtor ctorName
  forallTelescopeReducing info.type fun xs _ => do
    let fields := xs.extract info.numParams xs.size
    fields.toList.mapM fun v => do
      let n ← v.fvarId!.getUserName
      pure (toString n.eraseMacroScopes)

/-- Wrap goal `g` into a `CaseBlocker descr`. Returns the new (blocked) goal. -/
private def blockGoal (g : MVarId) (descr : String) : MetaM MVarId := g.withContext do
  let ty ← g.getType
  let lvl ← getLevel ty
  let blocked ← mkFreshExprMVar (mkApp2 (mkConst ``CaseBlocker [lvl]) (mkStrLit descr) ty)
  g.assign (mkApp3 (mkConst ``CaseBlocker.val [lvl]) (mkStrLit descr) ty blocked)
  pure blocked.mvarId!

private def blockerDescr? (g : MVarId) : MetaM (Option String) := do
  let ty ← instantiateMVars (← g.getType)
  if ty.isAppOfArity ``CaseBlocker 2 then
    if let Expr.lit (.strVal d) := ty.getArg! 0 then return some d
  return none

/-- Split the main goal according to the constructors of `x` (with `cases`, or `induction` when
`recursive := true`), revert the fields of each case so the player names them, and block every
case until it is announced. -/
private def splitCases (x : Ident) (recursive : Bool) : TacticM Unit := withMainContext do
  let fvarId ← getFVarId x
  let goal ← getMainGoal
  let xType ← whnfD (← inferType (mkFVar fvarId))
  let some indName := xType.getAppFn.constName? | throwError "`{x.getId}` is not an element of an inductive type."
  let indInfo ← getConstInfoInduct indName
  -- (goal, fields, constructor) for each case
  let subgoals : Array (MVarId × Array Expr × Name) ← if recursive then
      let r ← goal.induction fvarId (indName ++ `rec)
      pure ((r.zip indInfo.ctors.toArray).map fun (s, c) => (s.mvarId, s.fields, c))
    else
      let r ← goal.cases fvarId
      pure ((r.zip indInfo.ctors.toArray).map fun (s, c) => (s.mvarId, s.fields, s.ctorName.getD c))
  let mut newGoals : List MVarId := []
  for (mvar, fields, ctorName) in subgoals do
    let fvars := fields.filterMap fun e => if e.isFVar then some e.fvarId! else none
    let (_, g) ← mvar.revert fvars
    let short := if let .str _ s := ctorName then s else toString ctorName
    let fieldNames ← ctorFieldNames ctorName
    let fieldNames := if recursive ∧ !fieldNames.isEmpty then fieldNames ++ ["…"] else fieldNames
    let descr := s!"{x.getId.eraseMacroScopes} is {short}" ++ (fieldNames.foldl (· ++ " " ++ ·) "")
    newGoals := newGoals ++ [← blockGoal g descr]
  replaceMainGoal newGoals

elab "Let's" " consider all cases for " x:ident : tactic => splitCases x false

elab "Let's" " define it by recursion on " x:ident : tactic => splitCases x true

syntax caseOrder := (&"first" <|> &"next" <|> &"now")

elab "Let's" (ppSpace caseOrder)? " consider the case where " x:ident " is " c:ident args:(ppSpace colGt ident)* : tactic => withMainContext do
  -- Split first if no case for `x` has been announced yet.
  let hasBlock ← (← getGoals).anyM fun g => do
    return (← blockerDescr? g).any fun d => d.startsWith s!"{x.getId} is "
  unless hasBlock do
    if (← getLCtx).findFromUserName? x.getId |>.isSome then splitCases x false
    else throwError "There is no `{x.getId}` to consider cases for."
  -- Find the blocked goal for this constructor.
  let goals ← getGoals
  let wanted := s!"{x.getId} is {c.getId}"
  let mut found : Option MVarId := none
  for g in goals do
    if let some d ← blockerDescr? g then
      if d == wanted ∨ d.startsWith (wanted ++ " ") then found := some g; break
  let some g := found
    | throwError "There is no remaining case where `{x.getId}` is `{c.getId}`. The remaining cases are shown in the goals."
  setGoals (g :: goals.filter (· != g))
  evalTactic (← `(tactic| apply CaseBlocker.mk))
  if args.size > 0 then
    evalTactic (← `(tactic| intro $args*))
