import Game.Levels.EmptyWorld.L05_ProductWithEmpty

World "EmptyWorld"
Level 6

Title "Coproduct With Empty"

Introduction "Recall that for any types `A` and `B`, there is a *coproduct type* denoted `A ⊕ B`.

In particular, for any type `A`, we may form the product `A ⊕ Empty` with the empty type.

In general, coproduct types like `A ⊕ Empty` have two types of elements: those of the form `Sum.inl a` for some `a : A` and those of the form `Sum.inr x` for `x : Empty`.

But the empty type does not have any elements. So this second case does not exist.

It follows that the type `A ⊕ Empty` is *equivalent* to the type `A` in a sense we cannot yet make precise.

But we can at least show that there are functions `A → A ⊕ Empty` and `A ⊕ Empty → A`.

Your task in this level is to define these functions.
"

open ReintroductionToProofs

/-- For any type `A`, there are functions in both directions between the types `A` and `A ⊕ Empty`. -/
Statement {A : Type} : (A → A ⊕ Empty) × (A ⊕ Empty → A) := by
  Hint (hidden := true) "What is the logical structure of this type?"
  Let's construct the pair
  Hint (hidden := true) "Have a look at the library of definitions for a function whose domain is the empty type."
  Let's use Sum.inl
  Hint (hidden := true) "How do you construct elements of a function type?"
  Fix p : A ⊕ Empty
  Hint (hidden := true) "What strategy is available with an element of a coproduct type?"
  Let's first consider the case where p is inl a
  Let's use a
  Hint (hidden := true) "Announce the second case, `Let's next consider the case where {p} is inr x`, and then explain why it cannot occur."
  Let's next consider the case where p is inr x
  This is impossible because of x

Conclusion "If your answer does not use the function `Sum.inl`, you might have fun trying to solve this level again using it in an appropriate place."
