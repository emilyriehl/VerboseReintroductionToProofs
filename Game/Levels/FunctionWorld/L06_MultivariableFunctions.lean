import Game.Levels.FunctionWorld.L05_ConstantFunctions

World "FunctionWorld"
Level 6

Title "Multivariable Functions"


Introduction "Function types can be iterated.

In particular, given types `A`, `B`, and `C`, we may form the function types `(A → B) → C` and `A → (B → C)`. These types are not the same!

Elements of the type `(A → B) → C` are functions that take a function from `A` to `B` as input and return an element of type `C` as output. Functions of this form exist but they are relatively obscure.

By contrast, elements of the type `A → (B → C)` are *multivariable functions*, which take more than one input before returning an output. As these are relatively common, the simplified notation `A → B → C` is used as an abbreviation for the type `A → (B → C)`.

A multivariable function `f : A → B → C` takes a first input of type `A` and a second input of type `B` before returning an output of type `C`.

The element `f` may also be thought of as a function that takes an element of type `A` and returns an element of type `B → C`.

Given `f : A → B → C` and `a : A`, then `f a : B → C` is a function from `B` to `C`.

Then given `b : B` we can apply the function `f a` to get an element `f a b : C`.

In this level, you are given a multivariable function together with an element from its first input type. You are asked to define a function of the appropriate function type.

This level can be solved by starting with `Let's use`, starting with `We apply`, or starting with `Fix`. If you start with `Fix`, then you can continue with `Let's use` or with `We apply`. If this is your first time solving this level, try to find a different solution.
"

/-- Given an element `a : A` and a function of two variables `f : A → B → C`, define a function from `B → C` by evaluating the first variable of `f` at the element `a`. -/
Statement {A B C : Type} (a : A) (f : A → B → C) : B → C := by
  Fix b : B
  Hint (hidden := true) "You can write `Let's use` followed by `{f}` with two arguments, in the correct order, with spaces in between (but no parentheses). Alternatively you can write `We apply {f}`."
  We apply f
  Hint "Since `{f}` is a function with two variables, after `We apply {f}` we now have two goals, where we need to supply first an element of type `{A}` and then an element of type `{B}`. Lean records the first of these as the &ldquo;Active Goal&rdquo; and the second of these as &ldquo;Goal 2&rdquo;."
  Let's use a
  Hint (hidden := true) "Both `Let's use b` and `Let's use an assumption` can be used here."
  Let's use b

Conclusion "More generally, `A → B → C → D → E` abbreviates the iterated function type `A → (B → (C → (D → E)))`. Explicit parentheses must be used to express iterated function types with any other parenthesizations."
