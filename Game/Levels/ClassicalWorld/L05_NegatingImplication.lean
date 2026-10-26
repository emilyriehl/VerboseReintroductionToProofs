import Game.Levels.ClassicalWorld.L04_NegatingConjunction


World "ClassicalWorld"
Level 5

Title "Negating Implication"

Introduction "In Negation World, we proved that for any propositions `P` and `Q`:

`P ∧ ¬ Q ⇒ ¬ (P ⇒ Q)`.

Our aim in this level is to prove the converse implication using classical reasoning.

Good luck!
"

section
open Classical

/-- In classical logic, for any propositions `P` and `Q`, `¬ (P ⇒ Q)` implies `P ∧ ¬ Q`. -/
Statement {P Q : Prop} : ¬ (P → Q) → P ∧ ¬ Q := by
  Assume ni : ¬ (P → Q)
  Claim lemP : P ∨ ¬ P from Classical.em P
  Let's first consider the case where lemP is inl p
  Let's first prove that P
  We conclude by p
  Let's now prove that ¬ Q
  Assume q : Q
  We apply ni
  We conclude by fun _ ↦ q
  Let's next consider the case where lemP is inr np
  Let's prove it's contradictory
  We apply ni
  Assume p : P
  We conclude by absurd p np


Conclusion "As an extra challenge, can you solve this level by appealing to the law of excluded middle only once? Alternatively, move on to the Boss Level of Classical World."
