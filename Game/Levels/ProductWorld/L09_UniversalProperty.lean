import Game.Levels.ProductWorld.L08_ComponentFunctions

World "ProductWorld"
Level 9

Title "Universal property"

Introduction "We've seen that functions `f : X → A × B` into product types can be decomposed into component functions `fun x ↦ (f x).1 : X → A` and `fun x ↦ (f x).2 : X → B`.

We'll now consider the reversed process, defining a function into a product type from a pair of component functions.

To that end consider an arbitrary pair of functions `g : X → A` and `h : X → B` that have the same domain type `X` but are otherwise unrelated.

These functions can be combined to define a single function of type `X → A × B` whose component functions are defined by `g` and `h`, respectively.

Your task in this level is to define the operation that produces a function into a product type from a pair of component functions.

While it is not strictly necessary to solve this level, we use this opportunity to introduce the sentence `Set`. `Set` is similar to `Claim` from Implication World, but it is used for creating elements of types rather than proofs of propositions.

Suppose your context contains an element `p : (X → A) × (X → B)`. Using this element it is possible to define functions of type `X → A` and `X → B`. `Set` can be used to add these to your context with explicit names.

Writing `Set g : X → A := p.1` will add the function defined by the first component of `p` to your context and give it the name `g`. Similarly, writing `Set h : X → B := p.2` will add the function defined by the second component of `p` to your context and give it the name `h`.

Practice using `Set` while solving this level.
"

namespace ReintroductionToProofs

/-- A pair of functions `g : X → A` and `h : X → A` may be combined into a single function from `X` to the product type `A × B`. -/
Statement {X A B : Type} : (X → A) × (X → B) → (X → A × B) := by
  Hint (hidden := true) "The goal is a function type, so start with `Fix`."
  Fix f : (X → A) × (X → B)
  Set g : X → A := f.1
  Set h : X → B := f.2
  Hint (hidden := true) "The goal is still a function type, so continue with `Fix`."
  Fix x : X
  Hint (hidden := true) "The goal is a product type, so `Let's construct the pair` can be used to break the goal into pieces."
  Let's construct the pair
  Hint (hidden := true) "What sort of type does `{f}` belong to? Can we extract other elements from an element of this type?"
  Hint (hidden := true) "What type does `{f}.1` belong to? Is this useful?"
  Let's use g x
  Hint (hidden := true) "What type does `{f}.2` belong to? Is this useful?"
  Let's use h x

Conclusion "The *universal property* of the product is the correspondence between functions `X → A × B` into a product and pairs of functions `(X → A) × (X → B)`.

We are now ready for the Boss Level of Product World."


def Prod.lift {X A B : Type} : (X → A) × (X → B) → (X → A × B) :=
  fun f x ↦ ⟨f.1 x, f.2 x⟩

end ReintroductionToProofs

/-- `Set x : A := e` adds a new element `x : A` to your context, defined to be `e` (`Set x := e` lets Lean work out the type). It is like `Claim`, but for elements of types rather than proofs of propositions. For example, given elements `a : A` and `b : B`, you can write `Set p : A × B := ⟨a, b⟩` to add their pair to the context, or `Set f : A → B := fun _ ↦ b` to add the constant function at `b`. -/
TacticDoc «Set»

NewTactic «Set»

/-- For types `X`, `A`, and `B`, `Prod.lift : (X → A) × (X → B) → (X → A × B)` combines a pair of functions of types `X → A` and `X → B` to define a single function of type `X → A × B`. -/
DefinitionDoc ReintroductionToProofs.Prod.lift as "lift" in "Prod"

NewDefinition ReintroductionToProofs.Prod.lift
