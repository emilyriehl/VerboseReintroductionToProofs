import Game.Levels.AdvancedFunctionWorld.L04_ComposingSurjectivity

World "AdvancedFunctionWorld"
Level 5

Title "Injectivity"

Introduction "Recall that every function is *well-defined*. For any function `f : A → B`, we have proven that `∀ x y : A, x = y ⇒ f x = f y`.

A function `f : A → B` is *injective* if for every `x y : A`, `f x = f y` implies `x = y`.

This condition says that any output element of `f` has a unique corresponding input. Note that it is not necessary that any element of `B` is an output of an injective function. Instead, injectivity asserts that if two elements of `A` have the same output, then those elements must be equal.

Unlike well-definedness, the statement `∀ x y : A, f x = f y ⇒ x = y` is true for some functions `f` but false for others.

In this level, we will show that the function `not : Bool → Bool` is injective.

Recall that when `b : Bool`, Lean writes `! b` for `not b`.
"

/-- The function `not : Bool → Bool` is injective. -/
TheoremDoc ReintroductionToProofs.Bool.not_injective as "not_injective" in "Bool"

namespace ReintroductionToProofs

/-- The function `not : Bool → Bool` is injective. -/
Statement Bool.not_injective : ∀ x y : Bool, not x = not y → x = y := by
  Hint (hidden := true) "To prove a universally quantified statement, start with `Fix (x : Bool) (y : Bool)` to introduce arbitrary elements of type `Bool`."
  Fix (x : Bool) (y : Bool)
  Hint (hidden := true) "You should also assume the hypothesis `! {x} = ! {y}`, with `Assume p : not {x} = not {y}`. Here Lean writes `! {x}` for `not {x}`, where `not : Bool → Bool` is the boolean negation function."
  Assume p : not x = not y
  Hint (hidden := true) "This result can be proven in cases. Consider the cases for `{x}`, and within each of them the cases for `{y}`."
  Let's first consider the case where x is false
  Let's first consider the case where y is false
  We conclude by rfl
  Let's next consider the case where y is true
  Hint (hidden := true) "`{p}` is a contradictory hypothesis: a boolean is never equal to its own negation. So `This is impossible because of {p}` will close the goal."
  This is impossible because of p
  Let's next consider the case where x is true
  Let's first consider the case where y is false
  Hint (hidden := true) "This case is similar to the previous one. Can you figure out how to solve it?"
  This is impossible because of p
  Let's next consider the case where y is true
  We conclude by rfl

Conclusion "In the next levels, we will study general properties of injective functions."

/-- A function `f : A → B` is *injective* if `∀ x y : A, f x = f y ⇒ x = y`. -/
DefinitionDoc Function.injective as "injective" in "Function"

NewDefinition Function.injective

end ReintroductionToProofs
