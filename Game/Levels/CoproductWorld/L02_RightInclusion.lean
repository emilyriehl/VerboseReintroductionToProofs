import Game.Levels.CoproductWorld.L01_LeftInclusion

World "CoproductWorld"
Level 2

Title "Right Inclusion"

Introduction "For types `A` and `B`, the coproduct type `A ⊕ B` has two kinds of elements. The second kind can be thought of as copies of elements `b : A` included into the coproduct `A ⊕ B` *on the right*.

Lean has a built in function called `Sum.inr : B → A ⊕ B`, which can now be found in your library.

If the goal is to produce an element of `A ⊕ B`, writing `We apply Sum.inr` will convert this to a goal of producing an element of `B`.

The sentence `Let's construct an element of B` has the same effect. When the goal is a coproduct type `A ⊕ B`, writing it tells Lean that you plan to provide an element of type `B`, which should then be converted to an element of type `A ⊕ B` by applying the function `Sum.inr : B → A ⊕ B`. Thus, writing `Let's construct an element of B` will update the goal to type `B`.

Note that `Sum.inl, Sum.inr : A → A ⊕ A` are *different functions* (as long as the type `A` has at least one element) in a way we will be able to make more precise later.
"

/--
For types `A` and `B`, the function `Sum.inr : B → A ⊕ B` can be used to include elements of type `B` as elements of the coproduct type `A ⊕ B`.
-/
DefinitionDoc Sum.inr as "inr" in "Sum"

/-- For any `b : B`, there is an element `Sum.inr b : A ⊕ B`. -/
Statement {A B : Type} (b : B) : A ⊕ B := by
  Hint "To use the built in function `Sum.inr : B → A ⊕ B` to change the goal from `A ⊕ B` to `B` write `We apply Sum.inr`."
  We apply Sum.inr
  Let's use b

NewDefinition Sum.inr

Conclusion "The sentence `Let's construct an element of …` is useful for defining elements of coproduct types or defining functions valued in coproduct types. In the next level, we will begin to consider functions mapping out of coproduct types."

