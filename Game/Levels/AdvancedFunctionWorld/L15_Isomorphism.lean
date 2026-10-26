import Game.Levels.AdvancedFunctionWorld.L14_DoubleNegation

World "AdvancedFunctionWorld"
Level 15

Title "Isomorphism"

Introduction "Using function extensionality, we can give a third logically equivalence characterization of what it means for a function `f : A → B` to be bijective or invertible.

A function `f : A → B` is an *isomorphism* if there exists a function `g : B → A` so that `g ∘ f = id` and `f ∘ g = id`.

The first equation is between functions from `A` to `A`. By function extensionality, it is
equivalent to the condition that `∀ a : A, g (f a) = a`.

The second equation is between functions from `B` to `B`. By function extensionality, it is
equivalent to the condition that `∀ b : B, f (g b) = b`.

In Lean, isomorphisms of types are also called *equivalences*, perhaps acknowledging a newly discovered connection between dependent type theory and homotopy theory.

The goal in this level is to prove the logical equivalence between the conditions that whether `f` is invertible or whether `f` is an isomorphism.
"

/-- The function `f : A → B` is an isomorphism if and only if `f` is invertible. -/
TheoremDoc ReintroductionToProofs.Function.isomorphism_iff_invertible as "isomorphism_iff_invertible" in "Function"

namespace ReintroductionToProofs

/-- The function `f : A → B` is an isomorphism if and only if `f` is invertible. -/
Statement Function.isomorphism_iff_invertible {A B : Type} (f : A → B) : (∃ g : B → A, g ∘ f = id ∧ f ∘ g = id) ↔ (∃ g : B → A, (∀ a : A, g (f a) =a) ∧ (∀ b : B, f (g b) = b))  := by
  Let's first prove that (∃ g : B → A, g ∘ f = id ∧ f ∘ g = id) → (∃ g : B → A, (∀ a : A, g (f a) = a) ∧ (∀ b : B, f (g b) = b))
  Assume h : ∃ g : B → A, g ∘ f = id ∧ f ∘ g = id
  By h we get g such that (lh : g ∘ f = id) and (rh : f ∘ g = id)
  Let's prove that g works
  Let's first prove that ∀ a : A, g (f a) = a
  Fix a : A
  Hint (hidden := true) "`{g} (f {a})` is by definition `({g} ∘ f) {a}`, and `{lh}` rewrites the latter. Record the definitional equality with `Fact lem : ({g} ∘ f) {a} = {g} (f {a}) from rfl`, then rewrite."
  Fact lem₁ : (g ∘ f) a = g (f a) from rfl
  We rewrite using ← lem₁
  We rewrite using lh
  We conclude by rfl
  Let's now prove that ∀ b : B, f (g b) = b
  Fix b : B
  Fact lem₂ : (f ∘ g) b = f (g b) from rfl
  We rewrite using ← lem₂
  We rewrite using rh
  We conclude by rfl
  Let's now prove that (∃ g : B → A, (∀ a : A, g (f a) = a) ∧ (∀ b : B, f (g b) = b)) → (∃ g : B → A, g ∘ f = id ∧ f ∘ g = id)
  Assume h : ∃ g : B → A, (∀ a : A, g (f a) = a) ∧ (∀ b : B, f (g b) = b)
  By h we get g such that (linv : ∀ a : A, g (f a) = a) and (rinv : ∀ b : B, f (g b) = b)
  Let's prove that g works
  Let's first prove that g ∘ f = id
  Hint (hidden := true) "An equality between functions: `By funext it suffices to prove that ∀ a : A, ({g} ∘ f) a = id a`."
  By funext it suffices to prove that ∀ a : A, (g ∘ f) a = id a
  Fix a : A
  We conclude by linv applied to a
  Let's now prove that f ∘ g = id
  By funext it suffices to prove that ∀ b : B, (f ∘ g) b = id b
  Fix b : B
  We conclude by rinv applied to b

Conclusion "Now you are ready for the Boss Level."

end ReintroductionToProofs
