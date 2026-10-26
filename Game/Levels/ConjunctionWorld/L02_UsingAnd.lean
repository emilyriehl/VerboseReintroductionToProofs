import Game.Levels.ConjunctionWorld.L01_IntroducingAnd

World "ConjunctionWorld"
Level 2

Title "Using And"

Introduction "A hypothesis `h : P ∧ Q` provides explicit proofs of both `P` and `Q` which are denoted in Lean by `h.1 : P` and `h.2 : Q`.

Collectively, this expresses the pair of elimination rules for the logical operation of conjunction. They can also be given names with `By h we get hp : P and hq : Q`."

/-- If `P ∧ Q` is true then `P ∧ Q` is true. -/
Statement {P Q : Prop} (h : P ∧ Q) : P ∧ Q := by
  Hint "This can be solved in two ways. Can you find them both?"
  Let's first prove that P
  Hint (hidden := true) "Now the goal is just to prove `P`. Write `We conclude by {h}.1` to supply this proof."
  We conclude by h.1
  Hint (hidden := true) "Announce the other goal with `Let's now prove that Q`, then write `We conclude by {h}.2` to supply this proof."
  Let's now prove that Q
  We conclude by h.2

Conclusion "If this is your first time solving this level, delete your proof, and try to find another solution."
