import Game.Levels.NegationWorld.L02_Negation

World "NegationWorld"
Level 3

Title "Double Negation"

Introduction "The *double negation* of a proposition `P` is the proposition `¬ ¬ P`.

In this level, we reinterpret the construction from the previous level as a proof that the implication `P ⇒ ¬ ¬ P` is always true, no matter whether or not `P` is true.
"

/-- For any proposition `P`, `P ⇒ ¬ ¬ P`. -/
Statement {P : Prop} : P → ¬ ¬ P := by
  Hint (hidden := true) "The goal is to prove an implication. Which sentence can be used to get started?"
  Assume p : P
  Hint (hidden := true) "Recall that `¬ Q` is an abbreviation for the type `Q ⇒ False`."
  Hint (hidden := true) "The goal is to prove an implication. Which sentence can be used to get started?"
  Assume np : ¬ P
  Hint (hidden := true) "Recall that `¬ P` is an abbreviation for the type `P ⇒ False`."
  Hint (hidden := true) "We have an assumption `{np} : P ⇒ False`. What can be done with a proof of implication?"
  We conclude by np applied to p

Conclusion "Do you see how this relates to the previous level?"
