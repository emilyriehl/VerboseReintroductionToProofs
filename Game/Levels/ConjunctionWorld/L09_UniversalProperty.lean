import Game.Levels.ConjunctionWorld.L08_CurryingImplication

World "ConjunctionWorld"
Level 9

Title "Universal Property"

Introduction "The task in this level is to show another logical equivalence,
this time between the conjoined implications `(P ⇒ Q) ∧ (P ⇒ R)` and the implication `P ⇒ Q ∧ R`, which is implicitly parenthesized as `P ⇒ (Q ∧ R)`.

The proof will require an idea that we have not used for a while. We've seen that for propositions `S` and `T`,
`S ⇒ (S ⇒ T) ⇒ T` can be proven by introducing hypotheses `s : S` and `h : S ⇒ T`, at which point the goal is to prove `T`.
Then applying the hypothesis `h` reduces the goal to proving `S` which we know is true by `s`.

Recall there is special notation `h s : T` for the proof constructed by applying the hypothesis `h` to the hypothesis `s`.

This notation is justified by the analogy between proofs of implications like `h : S ⇒ T` and functions. The proof `h` can be thought of as a function that takes a proof `s : S` and returns a proof `h s : T`.
"

/-- `(P ⇒ Q) ∧ (P ⇒ R)` is true if and only if `P ⇒ (Q ∧ R)` is true. -/
Statement {P Q R : Prop} : (P → Q) ∧ (P → R) ↔ P → Q ∧ R := by
  Let's first prove that (P → Q) ∧ (P → R) → (P → Q ∧ R)
  Assume gh : (P → Q) ∧ (P → R)
  Assume p : P
  Let's first prove that Q
  We conclude by gh.1 applied to p
  Let's now prove that R
  We conclude by gh.2 applied to p
  Let's now prove that (P → Q ∧ R) → (P → Q) ∧ (P → R)
  Assume h : P → Q ∧ R
  Let's first prove that P → Q
  Assume p : P
  Hint "We can apply the proof `{h} : P ⇒ Q ∧ R` to the proof `{p}: P` to obtain `{h} {p} : Q ∧ R`. How can these be used to prove the goal?"
  We conclude by (h p).1
  Let's now prove that P → R
  Assume p : P
  Hint "We can apply the proof `{h} : P ⇒ Q ∧ R` to the proof `{p}: P` to obtain `{h} {p} : Q ∧ R`. How can these be used to prove the goal?"
  We conclude by (h p).2

Conclusion "Now we are ready for the Boss Level."
