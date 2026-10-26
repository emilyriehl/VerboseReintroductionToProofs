import Game.Levels.QuantifierWorld.L07_CommutingQuantifiers

World "QuantifierWorld"
Level 8

Title "Negating Existence"

Introduction "How would you disprove a statement of the form

`∃ x : A, P x`?

To do this, it is necessary to show that for *every* `a : A`, `P a` is not true.

That is, it is necessary to prove

`∀ x : A, ¬ (P x)`.

In this level we will prove `∀ x : A, ¬ (P x)` implies
`¬ (∃ x : A, P x)` and conversely.
"

/-- Given a family of propositions `P : A → Prop`,  `∀ x : A, ¬ (P x)` is logically equivalent to `¬ (∃ x : A, P x)` -/
Statement {A : Type} (P : A → Prop) : (∀ x : A, ¬ (P x)) ↔ ¬ (∃ x : A, P x) := by
  Hint (hidden := true) "Recall the meaning of `⇔`. Which sentence breaks this goal into its components?"
  Let's first prove that (∀ x : A, ¬ P x) → ¬ (∃ x : A, P x)
  Assume na : ∀ x : A, ¬ P x
  Assume ne : ∃ x : A, P x
  Hint (hidden := true) "How can you use the hypothesis `{ne}`?"
  By ne we get a such that ha : P a
  Fact npa : ¬ P a from na applied to a
  Hint (hidden := true) "There are various ways to use `{na}` and `{npa}` to get a contradiction."
  We conclude by npa applied to ha
  Let's now prove that ¬ (∃ x : A, P x) → ∀ x : A, ¬ P x
  Assume ne : ¬ (∃ x : A, P x)
  Fix a : A
  Hint (hidden := true) "The goal is a negation, that is, an implication: use `Assume`."
  Assume pa : P a
  Hint (hidden := true) "The hypothesis `{ne}` is a proof that `(∃ x, P x) ⇒ False`. So try `We apply {ne}`."
  We apply ne
  Let's prove that a works
  We conclude by pa

Conclusion "In the next level, we will learn about negating universal quantifiers."
