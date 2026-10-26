import Verbose.English.All

/-! # Game-specific phrases and synonyms

Verbose Lean phrases are ordinary Lean syntax, so synonyms are just extra `syntax`/`elab`
declarations that call the same elaborators. Phrasing here is provisional (Emily's call). -/

open Lean Elab Tactic Verbose.English

/-- `Let's use b`: close the goal with the element (or proof) `b`. Synonym of `We conclude by b`,
meant for goals that are types rather than propositions. -/
elab "Let's" " use " e:term : tactic => do
  concludeTac e

/-- `By h we get m such that k = 2 * m`: like `By h we get m such that hm : k = 2 * m` but the
new fact is named automatically (here `hm`). -/
elab "By " e:maybeApplied " we get " colGt news:newObjectNameLess : tactic => do
  obtainTac (← maybeAppliedToTerm e) (newObjectNameLessToArray news)

/-- `By p we get a : A and b : B` (also `(a : A) and (b : B)`, or just `a and b`): destructure a
pair `p : A × B` or a conjunction. Verbose's own form is `By p we get (a : A) (b : B)`. -/
elab (name := gameByWeGetAnd) "By " e:maybeApplied " we get " x:maybeTypedIdent " and " y:maybeTypedIdent : tactic => do
  obtainTac (← maybeAppliedToTerm e) #[toMaybeTypedIdent x, toMaybeTypedIdent y]
