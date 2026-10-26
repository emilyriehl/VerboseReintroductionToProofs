import Game.Levels.TypeWorld.L02_Proofs

World "TypeWorld"
Level 3

Title "Exact Elements"

Introduction "A more elaborate context may contain multiple types and multiple elements, or a mix of types, elements, propositions, and proofs.

Thus, we may require a more precise way to tell Lean which data or hypothesis from our context should be used.

In this level, our context includes two types `A` and `B` with three elements between them. Note the use of a space rather than a list to indicate that `y : B` and `z : B` each define elements of type `B`.

Our goal is to define an element of type `B` and the sentence `Let's use an assumption` will solve this goal. But this sentence does not convey to the reader which assumption was used.

In this sort of setting, it is better practice to name the element. If the goal has type `E` and there is an element `e : E` in the context, then `Let's use e` uses the element `e` to close the goal.

The same works when the goal is a proposition `P` and the context includes a proof `p : P`: then `Let's use p` solves the goal, and so does `We conclude by p`.
"

/-- Under the hypothesis that we have types `A` and `B` and elements `x : A` and `y z : B`, we may define an element of type `B`. -/
Statement {A B : Type} (x : A) (y z : B) : B := by
  Let's use z

Conclusion "After solving this level, use the `Retry` button to solve it again. What happens if you try `Let's use x`?"
