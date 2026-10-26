import Game.Levels.ImplicationWorld
import Game.Levels.ProductWorld

World "ConjunctionWorld"
Level 1

Title "Introducing And"

Introduction "To prove a conjunction `P ∧ Q` we need to supply a proof of both `P` and `Q`.

This expresses the introduction rule for the logical operation of conjunction.

Write `Let's first prove that P` to ask Lean to break up the goal of proving `P ∧ Q` into two steps: proving `P` now, and proving `Q` afterwards, which you announce with `Let's now prove that Q` when you get there.
"

/-- If `P` is true and `Q` is true, then `P ∧ Q` is true. -/
Statement {P Q : Prop} (p : P) (q : Q) : P ∧ Q := by
  Let's first prove that P
  Hint (hidden := true) "Now the goal is just to prove `P`. Write `We conclude by {p}` to supply this proof."
  We conclude by p
  Hint (hidden := true) "Lean now reminds you of the other goal, which is to prove `Q`, and asks you to announce it: write `Let's now prove that Q`. Then which sentence applies?"
  Let's now prove that Q
  We conclude by q

Conclusion "Alternatively, you can write `We conclude by ⟨p, q⟩` using `\\<` and `\\>` to type the angle brackets."
