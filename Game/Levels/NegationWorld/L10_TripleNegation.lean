import Game.Levels.NegationWorld.L09_NegatingConjunction

World "NegationWorld"
Level 10

Title "Triple Negation"

Introduction "This level contains another tautology whose proof you have seen before.

We will show that for any proposition `P`, if `P` is not not false, then `P` is false.

That is, we will prove `¬ ¬ ¬ P ⇒ ¬ P`.

In fact, for any proposition `P`, its negation `¬ P` and its triple negation `¬ ¬ ¬ P` are logically equivalent.

So we will prove this too.
"

/-- For any proposition `P`, `¬ P` is logically equivalent to `¬ ¬ ¬ P`. -/
Statement {P : Prop} : ¬ P ↔ ¬ ¬ ¬ P := by
  Let's first prove that ¬ P → ¬ ¬ ¬ P
  Hint (hidden := true) "Does this goal seem familiar? If not, it's okay to just follow your nose and let the logical structure guide you."
  Assume np : ¬ P
  Assume nnp : ¬ ¬ P
  We conclude by nnp applied to np
  Let's now prove that ¬ ¬ ¬ P → ¬ P
  Assume nnnp : ¬ ¬ ¬ P
  Hint (hidden := true) "What is the logical form of the goal?"
  Assume p : P
  Hint (hidden := true) "What can you do with hypothesis `{nnnp}`?"
  We apply nnnp
  Hint (hidden := true) "What is the logical form of the goal?"
  Assume np : ¬ P
  Hint (hidden := true) "How can you use `{p}` and `{np}` to get a contradiction?"
  We apply np
  We conclude by p

Conclusion "Does either proof in this logical equivalence seem familiar? Do they both seem familar?"
