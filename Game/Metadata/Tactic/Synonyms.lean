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
elab "By " e:maybeApplied " we get " colGt news:newObjectNameLess : tactic => do
  obtainTac (← maybeAppliedToTerm e) (newObjectNameLessToArray news)

/-- `By p we get a : A and b : B` (also `(a : A) and (b : B)`, or just `a and b`): destructure a
pair `p : A × B` or a conjunction. Verbose's own form is `By p we get (a : A) (b : B)`. -/
elab (name := gameByWeGetAnd) "By " e:maybeApplied " we get " x:maybeTypedIdent " and " y:maybeTypedIdent : tactic => do
  obtainTac (← maybeAppliedToTerm e) #[toMaybeTypedIdent x, toMaybeTypedIdent y]

/-- `Let's use an assumption`: close the goal with whichever element or proof in the context has
the right type, without naming it (the counterpart of the `assumption` tactic). -/
elab "Let's" " use an assumption" : tactic => do
  evalTactic (← `(tactic| assumption))
