import Game.Levels.FunctionWorld.L02_UsingFunctions

World "FunctionWorld"
Level 3

Title "Using Functions Backwards"

Introduction "
The context and goal for this level is identical to the previous level. We are given types `A` and `B`, a function `f : A → B` and an element `a : A`. The goal is to define an element of type `B`.

There is another sentence, `We apply f`, which can be used in the presence of a function to transform the goal. If `f : A → B` is part of the context and the goal is to define an element of type `B` then `We apply f` will update the goal to ask instead for an element of type `A`.

This proof strategy asks Lean to solve the initial goal by applying the function `f` to the element you provide next.

Try using `We apply` to solve this level.
"

/-- Given a function `f : A → B` and an element `a : A`, there is an element `f a : B` obtained by evaluating the function `f` at `a`. -/
Statement {A B : Type} (a : A) (f : A → B) : B := by
  Hint (hidden := true) "Start with `We apply f` to apply the function `f` to transform your goal."
  We apply f
  Let's use a

Conclusion "While the sentences used in this level and the previous one are different, both solutions ultimately tell Lean to use the element `f a : B` built by applying the function `f` to the element `a`."


-- `We apply f` is documented under `We` in the library.
