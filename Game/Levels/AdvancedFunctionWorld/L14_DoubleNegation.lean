import Game.Levels.AdvancedFunctionWorld.L13_FunctionExtensionality

World "AdvancedFunctionWorld"
Level 14

Title "Double Negation"

Introduction "Recall the function `not : Bool → Bool` that is defined to send the boolean `false` to `true` and to send the boolean `true` to `false`.

In Boolean World, we proved that `b = not (not b)` for any boolean `b : Bool`.

In this level, we will apply that result to prove that `id = not ∘ not` as functions `Bool → Bool`.
"

/-- The composite of the function `not : Bool → Bool` with itself equals the identity function -/
TheoremDoc ReintroductionToProofs.Bool.not_involutive as "not_involutive" in "Bool"

namespace ReintroductionToProofs

/-- The composite of the function `not : Bool → Bool` with itself equals the identity function -/
Statement Bool.not_involutive : not ∘ not = id := by
  Hint (hidden := true) "Write `By funext it suffices to prove that ∀ b : Bool, (not ∘ not) b = id b` to apply function extensionality, then `Fix b : Bool`."
  By funext it suffices to prove that ∀ b : Bool, (not ∘ not) b = id b
  Fix b : Bool
  Hint (hidden := true) "As our previous theorem is not in the library, we'll have to reprove it. Recall `rfl` only applies for *definitional* equalities, and we only have this for certain cases of Booleans. Consider the cases for `{b}`."
  Let's first consider the case where b is false
  We conclude by rfl
  Let's next consider the case where b is true
  We conclude by rfl

Conclusion "Next we will use function extensionality to prove a third characterization of bijective or invertible functions."

end ReintroductionToProofs
