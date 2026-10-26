import Game.Levels.CoproductWorld.L07_Distributivity

World "CoproductWorld"
Level 8

Title "Boss level"


Introduction "For the Boss Level, your task is to:

* break apart a function from a coproduct type into a product type into four separate component functions and

* then reassemble four component functions to a single function from a coproduct type into a product type.

Good luck!
"

/-- A function of type `A ⊕ B → C × D` can be broken into component functions of type `(A → C) × (B → C) × (A → D) × (B → D)` and conversely the component functions assemble into a function from the coproduct type to the product type. -/
Statement {A B C D : Type} : ((A ⊕ B → C × D) → (A → C) × (B → C) × (A → D) × (B → D)) × ((A → C) × (B → C) × (A → D) × (B → D) → (A ⊕ B → C × D)) := by
  Let's construct the pair
  Fix f : A ⊕ B → C × D
  Let's use ⟨fun a ↦ (f (Sum.inl a)).1, fun b ↦ (f (Sum.inr b)).1, fun a ↦ (f (Sum.inl a)).2, fun b ↦ (f (Sum.inr b)).2⟩
  Fix p : (A → C) × (B → C) × (A → D) × (B → D)
  By p we get (f : A → C) (g : B → C) (h : A → D) (k : B → D)
  Fix x : A ⊕ B
  Let's first consider the case where x is inl a
  Let's use ⟨f a, h a⟩
  Let's next consider the case where x is inr b
  Let's use ⟨g b, k b⟩

Conclusion "Next move on to Disjunction World to study the logical operation that is analogous to coproduct types."
