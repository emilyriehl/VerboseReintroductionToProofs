import Verbose.English.All

/-! # Game-specific phrases and synonyms

Verbose Lean phrases are ordinary Lean syntax, so synonyms are just extra `syntax`/`elab`
declarations that call the same elaborators. Phrasing here is provisional (Emily's call). -/

open Lean Meta Elab Tactic Verbose.English

/-- `Let's use b`: close the goal with the element (or proof) `b`. Synonym of `We conclude by b`,
meant for goals that are types rather than propositions. -/
elab "Let's" " use " e:term : tactic => withMainContext do
  try concludeTac e
  catch err =>
    let goal ← instantiateMVars (← getMainTarget)
    let ty? ← try
        let v ← Term.elabTerm e none
        some <$> instantiateMVars (← inferType v)
      catch _ => pure none
    match ty? with
    | some ty =>
      if ← isDefEq ty goal then throw err
      throwError m!"{e} has type {ty}, but the goal asks for an element of {goal}."
    | none => throw err

/-- `By h we get m such that k = 2 * m`: like `By h we get m such that hm : k = 2 * m` but the
new fact is named automatically (here `hm`). -/
-- Low priority: `(h : P)` is also a term, so Verbose's typed forms `… such that (h : P)` and
-- `… such that (h : P) and (h' : Q)` must win whenever both parse.
elab (name := gameByWeGetNameless) (priority := low) "By " e:maybeApplied " we get " colGt news:newObjectNameLess : tactic => do
  obtainTac (← maybeAppliedToTerm e) (newObjectNameLessToArray news)

/-- `By p we get a : A and b : B` (also `(a : A) and (b : B)`, or just `a and b`): destructure a
pair `p : A × B` or a conjunction. Verbose's own form is `By p we get (a : A) (b : B)`. -/
elab (name := gameByWeGetAnd) "By " e:maybeApplied " we get " x:maybeTypedIdent " and " y:maybeTypedIdent : tactic => do
  obtainTac (← maybeAppliedToTerm e) #[toMaybeTypedIdent x, toMaybeTypedIdent y]

/-- `Let's use an assumption`: close the goal with whichever element or proof in the context has
the right type, without naming it (the counterpart of the `assumption` tactic). -/
elab "Let's" " use an assumption" : tactic => do
  evalTactic (← `(tactic| assumption))

/-! ## `Claim P from e` without a name

Verbose's `Claim h : P from e` (the game does not offer its synonym `Fact`) requires a name. As with
`Assume that P`, the game also accepts the statement alone and names the new fact itself. -/
section ClaimNameless
open Lean Elab Tactic Verbose Verbose.English

elab (priority := low) "Claim " stmt:term " from " prf:maybeApplied : tactic => withMainContext do
  let e ← elabTerm stmt none
  let name ← mk_hyp_name stmt e
  let n := mkIdent name
  evalTactic (← `(tactic| have $n : $stmt := by We conclude by $prf))

elab (priority := low) "Claim " stmt:term " by " colGt prf:tacticSeq : tactic => withMainContext do
  let e ← elabTerm stmt none
  let name ← mk_hyp_name stmt e
  let n := mkIdent name
  evalTactic (← `(tactic| have $n : $stmt := by $prf))

end ClaimNameless
