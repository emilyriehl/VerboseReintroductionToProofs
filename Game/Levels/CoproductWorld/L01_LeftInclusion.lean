import Game.Levels.ProductWorld

World "CoproductWorld"
Level 1

Title "Left Inclusion"

Introduction "For types `A` and `B`, the coproduct type `A ⊕ B` has two kinds of elements. The first kind can be thought of as copies of elements `a : A` included into the coproduct `A ⊕ B` *on the left*.

Lean has a built in function called `Sum.inl : A → A ⊕ B`, which can now be found in your library.

If the goal is to produce an element of `A ⊕ B`, writing `We apply Sum.inl` will convert this to a goal of producing an element of `A`.

The sentence `Let's construct an element of A` has the same effect. When the goal is a coproduct type `A ⊕ B`, writing it tells Lean that you plan to provide an element of type `A`, which should then be converted to an element of type `A ⊕ B` by applying the function `Sum.inl : A → A ⊕ B`. Thus, writing `Let's construct an element of A` will update the goal to type `A`.
"

/--
For types `A` and `B`, the function `Sum.inl : A → A ⊕ B` can be used to include elements of type `A` as elements of the coproduct type `A ⊕ B`.
-/
DefinitionDoc Sum.inl as "inl" in "Sum"

/-- For any `a : A`, there is an element `Sum.inl a : A ⊕ B`. -/
Statement {A B : Type} (a : A) : A ⊕ B := by
  Hint "To define an element of type `A ⊕ B` by defining an element of type `A` and applying the function `Sum.inl : A → A ⊕ B`, start by writing `Let's construct an element of A`."
  Let's construct an element of A
  Let's use a

NewDefinition Sum.inl

Conclusion "The function `Sum.inl : A → A ⊕ B` provides the first introduction rule for coproduct types. In the next level, we will explore the second introduction rule."

-- `Let's construct an element of A` is documented under `Let's`.
