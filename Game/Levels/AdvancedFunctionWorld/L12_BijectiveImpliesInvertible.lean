import Game.Levels.AdvancedFunctionWorld.L11_InvertibleImpliesBijective

World "AdvancedFunctionWorld"
Level 12

Title "Bijective Implies Invertible"

Introduction "Suppose `f : A → B` is a bijective function, meaning `f` is both injective and surjective.

Then it follows that `f` is invertible.

The proof is more delicate, however, than the previous case as it requires classical logic rather than constructive logic.

To define an inverse for `f`, we must define a function `g : B → A` that &ldquo;un-does&rdquo; the action of `f`.
For an element `b : B`, we in particular want `g b : A` to be chosen so that `f (g b) = b`.

Our hypothesis that `f` is surjective tells us that `∃ x : A, f x = b`. But it doesn't give us a &ldquo;formula&rdquo; to pick a particular element of `A`.

Instead, we must appeal to something called the *axiom of choice* to make an explicit choice. We will
explain how to do so at that stage in the proof.
"

open Classical

/-- A bijective function is invertible. -/
TheoremDoc ReintroductionToProofs.Function.invertible_of_bijective as "invertible_of_bijective" in "Function"


namespace ReintroductionToProofs

/-- A bijective function is invertible. -/
Statement Function.invertible_of_bijective {A B : Type} (f : A → B) (inj : ∀ x y : A, f x = f y → x = y) (surj : ∀ b : B, ∃ x : A, f x = b) :
    ∃ g : B → A, (∀ a : A, g (f a) = a) ∧ (∀ b : B, f (g b) = b) := by
  Hint (hidden := true) "Start by defining the inverse function and giving it a name: `Set g : B → A := ??`. For each `b : B`, the surjectivity hypothesis provides `surj b : ∃ x : A, f x = b`, and the axiom of choice extracts an element satisfying this condition: `(surj b).choose : A`. So write `Set g : B → A := fun b ↦ (surj b).choose`."
  Set g : B → A := fun b ↦ (surj b).choose
  Hint "For each `b : B`, the theorem `(surj b).choose_spec` proves that the chosen element satisfies the equation `f ((surj b).choose) = b`. Now announce that `{g}` is the inverse: `Let's prove that {g} works`."
  Let's prove that g works
  Hint (hidden := true) "You have two things to prove. Announce the first with `Let's first prove that ∀ a : A, {g} (f a) = a`."
  Let's first prove that ∀ a : A, g (f a) = a
  Fix x : A
  Hint (hidden := true) "You are now meant to show that `{g} (f {x}) = {x}` for an arbitrary element `{x} : A`. Here you can apply the injectivity hypothesis by writing `We apply inj`."
  We apply inj
  Hint (hidden := true) "Now you are meant to show that `f ({g} (f {x})) = f {x}` for an arbitrary element `{x} : A`. The element `{g} (f {x})` was chosen using the surjectivity hypothesis so that when you apply `f` you get the element `f {x}` back. Write `We apply (surj (f {x})).choose_spec` to apply the other half of the surjectivity hypothesis at the element `f {x} : B`."
  We apply (surj (f x)).choose_spec
  Let's now prove that ∀ b : B, f (g b) = b
  Fix b : B
  Hint "Write `We apply (surj {b}).choose_spec` to apply the other half of the surjectivity hypothesis."
  We apply (surj b).choose_spec

Conclusion "The upshot of this level and the previous one is that in classical logic at least, a function is bijective if and only if it is invertible."

end ReintroductionToProofs

/-- Given a proof `h : ∃ a : A, P a` for some `P : A → Prop`, the axiom of choice selects an element
`h.choose : A`. The theorem `h.choose_spec` then proves the proposition `P (h.choose)`. -/
DefinitionDoc Classical.choose as "choose" in "Classical"

NewDefinition Classical.choose

/-- Given a proof `h : ∃ a : A, P a` for some `P : A → Prop`, `h.choose_spec` gives a proof that the
element `h.choose : A` satisfies `P (h.choose)`. -/
TheoremDoc Classical.choose_spec as "choose_spec" in "Classical"

NewTheorem Classical.choose_spec
