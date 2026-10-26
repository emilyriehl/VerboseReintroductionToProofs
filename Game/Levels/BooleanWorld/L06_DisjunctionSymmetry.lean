import Game.Levels.BooleanWorld.L05_Disjunction

World "BooleanWorld"
Level 6

Title "Disjunction Symmetry"

Introduction "For any booleans `x y : Bool`, `x || y = y || x`, capturing the symmetry of disjunction.

Here `x || y` is Lean's notation for `Bool.or x y`.
"

/-- The function `Bool.or : Bool → Bool → Bool`, written `||`, is symmetric. -/
Statement (x y : Bool) : Bool.or x y = Bool.or y x := by
  Hint (hidden := true) "Consider the cases for `{x}`, and inside each of them the cases for `{y}`."
  Let's first consider the case where x is false
  Let's first consider the case where y is false
  We conclude by rfl
  Let's next consider the case where y is true
  We conclude by rfl
  Let's next consider the case where x is true
  Let's first consider the case where y is false
  We conclude by rfl
  Let's next consider the case where y is true
  We conclude by rfl

Conclusion "Again four cases that hold by definition."
