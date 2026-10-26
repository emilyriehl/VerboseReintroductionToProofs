import Game.Levels.BooleanWorld.L02_DoubleNegation

World "BooleanWorld"
Level 3

Title "Conjunction"

Introduction "We have seen that the logical operation of negation can be encoded as a function `not : Bool → Bool`.

We can similarly define a function `Bool → Bool → Bool` that encodes the logical operation of conjunction.

Again, this level comes with two pre-defined goals: the first is to define the conjunction function `Bool → Bool → Bool` and the second is to check that your definition is correct by calculating the values of the function you defined on explicit pairs of booleans.
"

/-- There is a function `and : Bool → Bool → Bool` that captures the logical operation of conjunction. -/
Statement (preamble := refine let f := ?f; ⟨f, ?eq⟩) :
    ∃ f: Bool → Bool → Bool,
    f true true = true ∧
    f false true = false ∧
    f true false = false ∧
    f false false = false := by
  -- first, define the function
  Fix x : Bool
  Fix y : Bool
  Hint (hidden := true) "Consider the cases for `{x}` first: `Let's first consider the case where {x} is false`. Inside the case where `{x}` is `true`, consider the cases for `{y}`. Alternatively, you can define the function on one line with `Let's use fun x y ↦ match x, y with | ?, ? => ? | ?, ? => ? | ?, ? => ? | ?, ? => ?` replacing each `?` with appropriate boolean elements."
  Let's first consider the case where x is false
  Let's use false
  Let's next consider the case where x is true
  Let's first consider the case where y is false
  Let's use false
  Let's next consider the case where y is true
  Let's use true
  Hint "Now you are asked to check that the function `f : Bool → Bool → Bool` that you just defined actually *is* the conjunction function. Specifically, you are asked to check that `f true true = true ∧ f false true = false ∧ f true false = false ∧ f false false = false`."
  -- now prove that you defined the right thing
  We conclude by ⟨rfl, rfl, rfl, rfl⟩

Conclusion "Was it necessary to consider all four cases of two boolean elements or can you define
this function by considering fewer cases? If using `match`, try replacing one of the input booleans with `_` to indicate that the value does not matter. The function `Bool.and`, written `x && y`, is now in your library."

/-- The function `Bool.and : Bool → Bool → Bool`, written `x && y`, captures the logical operation of conjunction. -/
DefinitionDoc Bool.and as "&&" in "Bool"

NewDefinition Bool.and
