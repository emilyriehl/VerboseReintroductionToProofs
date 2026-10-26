import Game.Levels.EquivalenceWorld.L06_MoreComponentFunctions

World "EquivalenceWorld"
Level 7

Title "Boss Level"

Introduction "For the Boss Level of Equivalence World you are asked to establish an equivalence between a priori unrelated types.

One of these is the coproduct of the unit type `Unit` with itself. Recall the unit type has a canonical element `() : Unit`.

The other is the type of booleans `Bool` which has two canonical elements `false true : Bool`.

Be careful how you define the functions `Unit ⊕ Unit → Bool` and `Bool → Unit ⊕ Unit`. If you make a wrong choice, you will not be able to solve the rest of this level.
"

open ReintroductionToProofs


/-- The types `Unit ⊕ Unit` and `Bool` are equivalent. -/
Statement : Unit ⊕ Unit ≃ Bool := by
  Hint (hidden := true) "Write `Let's construct it componentwise` to split the goal up into the four proof obligations."
  Let's construct it componentwise
  Fix x : Unit ⊕ Unit
  Let's first consider the case where x is inl u
  Let's use false
  Let's next consider the case where x is inr u
  Let's use true
  Fix b : Bool
  Let's first consider the case where b is false
  Hint (hidden := true) "Both summands are `Unit`, so name the injection explicitly: `Let's use Sum.inl ()` or `Let's use Sum.inr ()`."
  Let's use Sum.inl ()
  Let's next consider the case where b is true
  Let's use Sum.inr ()
  Fix x : Unit ⊕ Unit
  Let's first consider the case where x is inl u
  We conclude by rfl
  Let's next consider the case where x is inr u
  We conclude by rfl
  Fix b : Bool
  Let's first consider the case where b is false
  We conclude by rfl
  Let's next consider the case where b is true
  We conclude by rfl

Conclusion "The equivalence between the types `Unit ⊕ Unit` and `Bool` has to do with the fact that both are examples of *inductive types*. In Natural Numbers World, we will finally properly introduce another inductive type, namely the type `ℕ` of natural numbers. Go there next."
