import Game.Levels.EquivalenceWorld.L05_ComponentFunctions

World "EquivalenceWorld"
Level 6

Title "More Component Functions"

Introduction "Another equivalence of types captures the full universal property of coproduct types.

Namely the type of functions `A ⊕ B → C` out of a coproduct type is equivalent to the type of functions

`(A → C) × (B → C)`

defined by taking the product of two function types.
"

namespace ReintroductionToProofs

/-- For any types `A`, `B`, and `C`, the types `A ⊕ B → C` and `(A → C) × (B → C)` are equivalent. -/
Statement {A B C : Type} : (A ⊕ B → C) ≃ (A → C) × (B → C) := by
  Hint (hidden := true) "Write `Let's construct it componentwise` to split the goal up into the four proof obligations."
  Let's construct it componentwise
  Hint (hidden := true) "This function is in the library. Rather than redefine it, can you use it?"
  Let's use Sum.components
  Hint (hidden := true) "You have a very close approximation to this function in your library. Can you see how to modify it to have the form you need here?"
  Let's use Function.uncurry Sum.lift
  Fix f : A ⊕ B → C
  Hint (hidden := true) "This is not a definitional equality, so requires the use of function extensionality: `By funext it suffices to prove that ∀ x : A ⊕ B, Function.uncurry Sum.lift (Sum.components f) x = f x` reduces this to proving the equality of functions at each input."
  By funext it suffices to prove that ∀ x : A ⊕ B, Function.uncurry Sum.lift (Sum.components f) x = f x
  Fix x : A ⊕ B
  Let's first consider the case where x is inl a
  We conclude by rfl
  Let's next consider the case where x is inr b
  We conclude by rfl
  Fix f : (A → C) × (B → C)
  We conclude by rfl

Conclusion "We are now ready for the Boss Level of Equivalence World."

end ReintroductionToProofs
