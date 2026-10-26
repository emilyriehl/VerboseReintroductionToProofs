import Game.Levels.BooleanWorld.L04_ConjunctionSymmetry

World "BooleanWorld"
Level 5

Title "Disjunction"

Introduction "We have seen that the logical operation of negation can be encoded as a function `not : Bool → Bool`.

We have also defined a function `Bool.and : Bool → Bool → Bool`, written `&&`, that encodes the logical operation of conjunction.

In this level, we will define a function `Bool → Bool → Bool` that encodes the logical operation of disjunction.

Again, this level comes with two pre-defined goals: the first is to define the disjunction function `Bool → Bool → Bool` and the second is to check that your definition is correct by calculating the values of the function you defined on explicit pairs of booleans.
"

/-- There is a function `or : Bool → Bool → Bool` that captures the logical operation of disjunction. -/
Statement (preamble := refine let f := ?f; ⟨f, ?eq⟩) :
    ∃ f: Bool → Bool → Bool,
    f true true = true ∧
    f false true = true ∧
    f true false = true ∧
    f false false = false := by
  -- first, define the function
  Fix x : Bool
  Fix y : Bool
  Hint (hidden := true) "Consider the cases for `{x}` first, and inside the case where `{x}` is `false`, the cases for `{y}`."
  Let's first consider the case where x is false
  Let's first consider the case where y is false
  Let's use false
  Let's next consider the case where y is true
  Let's use true
  Let's next consider the case where x is true
  Let's use true
  -- now prove that you defined the right thing
  We conclude by ⟨rfl, rfl, rfl, rfl⟩

Conclusion "Was it necessary to consider all four cases of two boolean elements or can you define this function by considering fewer cases? The function `Bool.or`, written `x || y`, is now in your library."

/-- The function `Bool.or : Bool → Bool → Bool`, written `x || y`, captures the logical operation of disjunction. -/
DefinitionDoc Bool.or as "||" in "Bool"

NewDefinition Bool.or
