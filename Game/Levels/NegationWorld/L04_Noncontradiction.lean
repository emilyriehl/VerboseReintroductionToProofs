import Game.Levels.NegationWorld.L03_DoubleNegation

World "NegationWorld"
Level 4

Title "Noncontradiction"

Introduction "For any proposition `P`, the following is true:

`¬ (P ∧ ¬ P)`

This is sometimes called the *law of noncontradiction*.

It asserts that it is not the case that both `P` and `¬ P` are true.

Do you see how this relates to the previous levels?
"

/-- For any proposition `P`, `¬ (P ∧ ¬ P)`. -/
Statement {P : Prop} : ¬ (P ∧ ¬ P) := by
  Hint (hidden := true) "Recall that `¬ Q` is an abbreviation for the type `Q ⇒ False`."
  Hint (hidden := true) "The goal is a negation, that is, an implication. Which sentence can be used to start?"
  Assume c : P ∧ ¬ P
  Hint (hidden := true) "Recall that `{c}.1` and `{c}.2` are the notations used for components of a conjunction, like `{c} : P ∧ ¬ P`. You can use these names directly or introduce them as assumptions with `By {c} we get p : P and np : ¬ P`."
  Hint (hidden := true) "What is the logical structure of the type that `{c}.2` belongs to?"
  We apply c.2
  We conclude by c.1

Conclusion "In the next level, we will see that a contradiction of the form `P ∧ ¬ P` can be used to prove any proposition."
