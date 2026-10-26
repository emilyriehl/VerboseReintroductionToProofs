import Game.Levels.QuantifierWorld.L09_NegatingUniversality

World "QuantifierWorld"
Level 10

Title "Boss Level"

Introduction "We have just proven an implication

`(∃ x : A, ¬ (P x)) → ¬ (∀ x : A, P x)`.

Use classical logic to prove the converse implication.

Good luck!
"

open Classical

/-- Given a family of propositions `P : A → Prop`, using classical logic, `¬ (∀ x : A, P x)` implies `∃ x : A, ¬ (P x)`.  -/
Statement {A : Type} (P : A → Prop) : ¬ (∀ x : A, P x) → (∃ x : A, ¬ (P x)) := by
  Assume na : ¬ (∀ x : A, P x)
  Assume for contradiction ne : ¬ (∃ x : A, ¬ P x)
  We apply na
  Fix a : A
  Claim p : P a ∨ ¬ P a from Classical.em (P a)
  Let's first consider the case where p is inl pa
  We conclude by pa
  Let's next consider the case where p is inr npa
  Let's prove it's contradictory
  We apply ne
  Let's prove that a works
  We conclude by npa

Conclusion "Move on to Advanced Function World to use quantifiers to study important properties of functions."
