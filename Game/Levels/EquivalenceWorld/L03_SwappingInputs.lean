import Game.Levels.EquivalenceWorld.L02_CoproductSymmetry

World "EquivalenceWorld"
Level 3

Title "Swapping Inputs"

Introduction "Function types are *not* symmetric: when `A` is non-empty, the types `Empty → A` and `A → Empty` are not equivalent.

However in the case of functions with multiple variables, the input variables can be exchanged.

In this level, you will show that the types `A → B → C` and `B → A → C` are equivalent.
"

open ReintroductionToProofs

/-- For any types `A`, `B`, and `C`, the function types `A → B → C` and `B → A → C` are equivalent. -/
Statement {A B C : Type} : (A → B → C) ≃ (B → A → C) := by
  Hint (hidden := true) "Write `Let's construct it componentwise` to split the goal up into the four proof obligations."
  Let's construct it componentwise
  Let's use Function.swap
  Let's use Function.swap
  Fix f : A → B → C
  We conclude by rfl
  Fix f : B → A → C
  We conclude by rfl

Conclusion "In the next level, we will establish another equivalence involving function types."
