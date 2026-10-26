import Game.Levels.DisjunctionWorld.L04_Symmetry

World "DisjunctionWorld"
Level 5

Title "Universal Property"

Introduction "
What must be true in order to have `P ∨ Q ⇒ R`?

On the one hand, if `P ∨ Q ⇒ R` is true, then `P ⇒ R` is true, because `P` implies `P ∨ Q`, which implies `R`.

Similar reasoning shows that if `P ∨ Q ⇒ R` is true, then `Q ⇒ R` is true.

Conversely, if *either* `P ⇒ R` or `Q ⇒ R` are true, this does not necessarily imply that `P ∨ Q ⇒ R` is true. Can you see why?

However, if *both* `P ⇒ R` and `Q ⇒ R` are true, then `P ∨ Q ⇒ R` is true, as you can argue using the strategy of proof by cases.

The aim of this level is to establish a logical equivalence between `P ∨ Q ⇒ R` and `(P ⇒ R) ∧ (Q ⇒ R)`."

/-- `P ∨ Q ⇒ R` is true if and only if `(P ⇒ R) ∧ (Q ⇒ R)` is true. -/
Statement {P Q R : Prop} : (P ∨ Q → R) ↔ (P → R) ∧ (Q → R) := by
  Hint (hidden := true) "What is the outermost logical connective?"
  Let's first prove that (P ∨ Q → R) → (P → R) ∧ (Q → R)
  Assume h : P ∨ Q → R
  Let's first prove that P → R
  Assume p : P
  Hint (hidden := true) "Try applying the hypothesis `{h}`."
  We apply h
  We conclude by Or.inl p
  Let's now prove that Q → R
  Assume q : Q
  Hint (hidden := true) "Try applying the hypothesis `{h}`."
  We apply h
  We conclude by Or.inr q
  Let's now prove that (P → R) ∧ (Q → R) → (P ∨ Q → R)
  Assume h : (P → R) ∧ (Q → R)
  Assume k : P ∨ Q
  Let's first consider the case where k is inl p
  Hint (hidden := true) "What implications can you extract from `{h}`?"
  We apply h.1
  We conclude by p
  Let's next consider the case where k is inr q
  We apply h.2
  We conclude by q

Conclusion "This logical equivalence captures the *universal property* of disjunction, explaining how the mathematical or is used in a proof."
