import Game.Levels.QuantifierWorld.L08_NegatingExistence

World "QuantifierWorld"
Level 9

Title "Negating Universality"

Introduction "How would you disprove a statement of the form

`∀ x : A, P x`?

To do this, it would suffice to find a single `a : A` so that `P a` is not true.

That is, it would suffice to prove

`∃ x : A, ¬ (P x)`.

In this level we will prove `∃ x : A, ¬ (P x)` implies
`¬ (∀ x : A, P x)`.
"

/-- Given a family of propositions `P : A → Prop`,  `∃ x : A, ¬ (P x)` implies `¬ (∀ x : A, P x)` -/
Statement {A : Type} (P : A → Prop) : (∃ x : A, ¬ (P x)) → ¬ (∀ x : A, P x)  := by
  Assume en : ∃ x : A, ¬ P x
  Hint (hidden := true) "The goal is a negation, that is, an implication: use `Assume`."
  Assume na : ∀ x : A, P x
  Hint (hidden := true) "To apply the hypothesis `{na}` it would help to have a specific element of `A` to apply it to. Can you see where this might come from?"
  By en we get a such that ha : ¬ P a
  We conclude by ha applied to na a

Conclusion "The converse implication is classical but not constructive as you will show in the Boss Level."
