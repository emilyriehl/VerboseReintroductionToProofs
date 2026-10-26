import Game.Levels.EqualityWorld.L08_UnitProposition

World "EqualityWorld"
Level 9

Title "Empty Proposition"

Introduction "Recall from Empty World, that Lean has a built in empty type `Empty` which has no elements.

The empty type is also a proposition: if `x y : Empty`, then `x = y`. Can you prove this?
"

/-- The empty type is a proposition: for `x y : Empty`, `x = y`. -/
Statement {x y : Empty} : x = y  := by
  Hint (hidden := true) "Write `This is impossible because of x`, or `Let's consider all cases for x` to consider all possible cases for an element of `Empty`."
  This is impossible because of x

Conclusion "In the next level, we will see that the equality type is itself a proposition."
