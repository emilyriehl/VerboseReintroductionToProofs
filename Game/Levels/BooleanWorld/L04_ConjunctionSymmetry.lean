import Game.Levels.BooleanWorld.L03_Conjunction

World "BooleanWorld"
Level 4

Title "Conjunction Symmetry"

Introduction "For any booleans `x y : Bool`, `x && y = y && x`, capturing the symmetry of conjunction.

Here `x && y` is Lean's notation for `Bool.and x y`.
"

/-- The function `Bool.and : Bool → Bool → Bool`, written `&&`, is symmetric. -/
Statement (x y : Bool) : Bool.and x y = Bool.and y x := by
  Hint (hidden := true) "Consider the cases for `{x}`, and inside each of them the cases for `{y}`; each of the four cases holds by definition."
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

Conclusion "Four cases, four times `We conclude by rfl`: later worlds introduce sentences that let Lean do such computations for you."
