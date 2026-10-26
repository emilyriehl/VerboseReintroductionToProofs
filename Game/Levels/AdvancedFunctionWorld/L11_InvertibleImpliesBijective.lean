import Game.Levels.AdvancedFunctionWorld.L10_InverseInvertibility

World "AdvancedFunctionWorld"
Level 11

Title "Invertible Implies Bijective"

Introduction "Suppose `f : A → B` is an invertible function, with an inverse function `g : B → A`.

Then it follows that `f` is bijective, both injective and surjective.

Your objective this level is to prove this.
"

/-- An invertible function is bijective. -/
TheoremDoc ReintroductionToProofs.Function.bijective_of_invertible as "bijective_of_invertible" in "Function"

namespace ReintroductionToProofs

/-- An invertible function is bijective. -/
Statement Function.bijective_of_invertible {A B : Type} (f : A → B) (inv : ∃ g : B → A, (∀ a : A, g (f a) = a) ∧ (∀ b : B, f (g b) = b)) : (∀ x y : A, f x = f y → x = y) ∧ (∀ b : B, ∃ x : A, f x = b) := by
  Hint (hidden := true) "Extract the inverse and its two properties from `inv`: `By inv we get g such that (linv : ∀ a : A, g (f a) = a) and (rinv : ∀ b : B, f (g b) = b)`."
  By inv we get g such that (linv : ∀ a : A, g (f a) = a) and (rinv : ∀ b : B, f (g b) = b)
  Let's first prove that ∀ x y : A, f x = f y → x = y
  Fix (x : A) (y : A)
  Assume p : f x = f y
  Hint (hidden := true) "Rewrite `{x}` and `{y}` as `{g} (f {x})` and `{g} (f {y})` using `{linv}` backwards, then use `{p}`: `We rewrite using [← {linv} {x}, ← {linv} {y}, {p}]`."
  We rewrite using [← linv x, ← linv y, p]
  We conclude by rfl
  Let's now prove that ∀ b : B, ∃ x : A, f x = b
  Fix b : B
  Let's prove that g b works
  We conclude by rinv applied to b

Conclusion "In the proof that `f` is injective, you used only one half of the invertibility condition. Can you use this observation to state a theorem that proves that `f` is injective under a weaker hypothesis? Similarly, in the proof that `f` is surjective, you used only the other half of the invertibility condition. Can you use this observation to state a theorem that proves that `f` is surjective under a weaker hypothesis?"

end ReintroductionToProofs
