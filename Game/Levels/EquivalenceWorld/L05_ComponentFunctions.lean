import Game.Levels.EquivalenceWorld.L04_CurryingUncurrying

World "EquivalenceWorld"
Level 5

Title "Component Functions"

Introduction "Another equivalence of types captures the full universal property of product types.

Namely the type of functions `X → A × B` into a product type is equivalent to the type of functions

`(X → A) × (X → B)`

defined by taking the product of two function types.
"

namespace ReintroductionToProofs

/-- For any types `X`, `A`, and `B`, the types `X → A × B` and `(X → A) × (X → B)` are equivalent. -/
Statement {X A B : Type} : (X → A × B) ≃ (X → A) × (X → B) := by
  Hint (hidden := true) "Write `Let's construct it componentwise` to split the goal up into the four proof obligations."
  Let's construct it componentwise
  Hint (hidden := true) "This function is in the library. Rather than redefine it, can you use it?"
  Let's use Prod.components
  Hint (hidden := true) "This function is in the library. Rather than redefine it, can you use it?"
  Let's use Prod.lift
  Fix f : X → A × B
  We conclude by rfl
  Fix f : (X → A) × (X → B)
  We conclude by rfl

Conclusion "In the next level, we will prove a similar universal property for coproduct types."

end ReintroductionToProofs
