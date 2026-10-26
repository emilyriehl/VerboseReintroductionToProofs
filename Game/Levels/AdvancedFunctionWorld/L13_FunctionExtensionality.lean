import Game.Levels.AdvancedFunctionWorld.L12_BijectiveImpliesInvertible

World "AdvancedFunctionWorld"
Level 13

Title "Function Extensionality"

Introduction "Suppose that `f g : A → B` are functions. What does it mean for these functions to be equal?

There is an idea that a function is determined by its values. In fact, we have `rfl : f = fun x ↦ f x`, meaning that the function `f` is definitionally equal to the function defined by the formula `x ↦ f x`. This is sometimes called the `η-rule` for functions.

Similarly of course `rfl : g = fun x ↦ g x`. So when does `f = g`?

By transitivity of equality, it suffices for `fun f ↦ f x` and `fun x ↦ g x` to be equal.

This suggests that it suffices to have a proof `p x : f x = g x` for all elements `x : A`.

To reduce the question of proving an equality `f = g` to the question of proving that `f x = g x` for all `x : A`, we must appeal to an axiom called *function extensionality*.

In Lean, function extensionality is the theorem `funext`. To use it, write `By funext it suffices to prove that ∀ x : A, f x = g x`: the goal `f = g` is replaced by the statement after &ldquo;prove that&rdquo;.
"

namespace ReintroductionToProofs

/-- For functions `f g : A → B` if `∀ x : A, f x = g x` then `f = g`. -/
Statement {A B : Type} {f g : A → B} (p : ∀ x : A, f x = g x) : f = g  := by
  Hint "Write `By funext it suffices to prove that ∀ x : A, f x = g x` to apply function extensionality and see how the goal state transforms."
  By funext it suffices to prove that ∀ x : A, f x = g x
  Fix x : A
  We conclude by p applied to x

Conclusion "In the next level, we will practice using function extensionality to demonstrate an equality between functions."

end ReintroductionToProofs

/-- Function extensionality: for functions `f g : A → B`, `funext : (∀ x : A, f x = g x) → f = g`. To use it on a goal `f = g`, write `By funext it suffices to prove that ∀ x : A, f x = g x`. -/
TheoremDoc funext as "funext" in "Function"

NewTheorem funext
