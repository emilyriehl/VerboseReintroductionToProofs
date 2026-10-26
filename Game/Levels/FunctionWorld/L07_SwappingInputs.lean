import Game.Levels.FunctionWorld.L06_MultivariableFunctions

World "FunctionWorld"
Level 7

Title "Swapping Inputs"

Introduction "Recall that an element of type `A → B → C` can be thought of as a function of two variables.

Given `f : A → B → C`, `a : A`, and `b : B`, `f a b : C` denotes `f` applied first to `a` and then to `b`.

From a function of type `A → B → C`, we can define a function of type `B → A → C` by exchanging the order of the variables that are input into the function.

Here the goal is a multivariable function type that takes three inputs &mdash; of types `A → B → C` and `B` and `A` &mdash; and returns one ouput, of type `C`. Introduce the three inputs one at a time with three `Fix` sentences (`Fix f : _` lets Lean fill in the type), or all at once with `Fix (f : A → B → C) (b : B) (a : A)`, or simply `Fix f b a` when you are happy to let Lean fill in all the types.
"

/-- From a function of two variables, define another function of two variables, where the inputs are swapped. -/
Statement {A B C : Type} : (A → B → C) → (B → A → C) := by
  Hint (hidden := true) "When in doubt, start defining a function with `Fix` followed by your preferred variable name and its type."
  Fix f : A → B → C
  Hint (hidden := true) "When in doubt, start defining a function with `Fix` followed by your preferred variable name and its type."
  Fix b : B
  Hint (hidden := true) "When in doubt, start defining a function with `Fix` followed by your preferred variable name and its type."
  Fix a : A
  Hint (hidden := true) "Look carefully at the order of the arguments of `{f}`."
  Let's use f a b

Conclusion "Note that for a particular multivariable function `f : A → B → C`, its type dictates that the variable of type `A` must be supplied before the variable of type `B`. But as observed in this level, we can then define a corresponding function `swap f : B → A → C` which encodes the same information."

/-- For any types `A`, `B`, and `C` and function `f : A → B → C`, `Function.swap f : B → A → C` is the function that carries `b : B` and `a : A` to `f a b : C`. -/
DefinitionDoc Function.swap as "swap" in "Function"

NewDefinition Function.swap
