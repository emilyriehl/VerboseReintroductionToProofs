import Game.Levels.BooleanWorld.L01_Negation

World "BooleanWorld"
Level 2

Title "Double Negation"

Introduction "In the last level, we defined the negation function
`not : Bool → Bool` which sends the element `false` to `true` and `true` to `false`.

The negation has the property that for any boolean `b : Bool`, `b = not (not b)`.

Interestingly the proof is not by reflexivity! This is because we only defined `not b` to have a particular value when `b` is one of the elements `false` or `true`.

See if this is enough of a hint to solve this level. (The case sentences work on a proposition about `b` just as well as on a construction.)

Note Lean has an alternate notation `! b` for `not b`.
"

/-- For any `b : Bool`, `b = not (not b)`. -/
Statement (b : Bool) : b = not (not b)  := by
  Let's consider all cases for b
  Let's first consider the case where b is false
  We conclude by rfl
  Let's next consider the case where b is true
  We conclude by rfl

Conclusion "It follows that `not ∘ not : Bool → Bool` is equal to the identity function by something called *function extensionality* that will be discussed in Advanced Function World."
