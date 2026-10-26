import Game.Levels.AdvancedFunctionWorld.L01_TotalFunctions

World "AdvancedFunctionWorld"
Level 2

Title "Surjectivity"

Introduction "Recall that every function is *total*. For any function `f : A → B`, we have proven that
`∀ x : A, ∃ y : B, f x = y`.

A function `f : A → B` is *surjective* if for every `y : B` there exists some `x : A` so that `f x = y`.

The condition asserts that every element of `B` is an output of the function `f` for some element of `A`. For each `y : B` there is some `x : A` so that `f x = y`.

Unlike totality, the statement `∀ y : B, ∃ x : A, f x = y` is true for some functions but false for others.

In this level, we will show that the function `not : Bool → Bool` is surjective.
"

/-- The function `not : Bool → Bool` is surjective. -/
TheoremDoc ReintroductionToProofs.Bool.not_surjective as "not_surjective" in "Bool"

namespace ReintroductionToProofs

/-- The function `not : Bool → Bool` is surjective. -/
Statement Bool.not_surjective : ∀ b : Bool, ∃ x : Bool, not x = b := by
  Hint (hidden := true) "To prove a universally quantified statement, start with `Fix b : Bool` to introduce an arbitrary element of type `Bool`."
  Fix b : Bool
  Hint "Here Lean writes `! x` for `not x`, where `not : Bool → Bool` is the boolean negation function."
  Hint (hidden := true) "Now you must give an explicit element `x : Bool`, so that `not x = {b}`. To do this, you need to know which boolean `{b}` is! Write `Let's first consider the case where {b} is false`, and later `Let's next consider the case where {b} is true`."
  Let's first consider the case where b is false
  Hint (hidden := true) "Announce the element with `Let's prove that ?? works`."
  Let's prove that true works
  We conclude by rfl
  Let's next consider the case where b is true
  Let's prove that false works
  We conclude by rfl

Conclusion "In the next levels, we will study general properties of surjective functions."

/-- A function `f : A → B` is *surjective* if `∀ y : B, ∃ x : A, f x = y`. -/
DefinitionDoc Function.surjective as "surjective" in "Function"

NewDefinition Function.surjective

end ReintroductionToProofs
