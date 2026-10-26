import Game.Levels.NegationWorld
import Game.Levels.EqualityWorld

World "BooleanWorld"
Level 1

Title "Negation"

Introduction "Recall the type `Bool` of booleans has two elements denoted `false : Bool` and `true : Bool`.

In this level, our aim is to define a function `Bool → Bool` that encodes the logical operation of negation, i.e., sends `false` to `true` and `true` to `false`.

You can start to define this function in the usual way, by writing `Fix b : Bool`. Lean will then update the goal to ask you to supply an element of type `Bool`. But which element should you pick?

The correct answer depends on whether `b` is `false` or `true`. The type of Booleans is an example of an *inductive type*, which is
similar to a coproduct type, and thus you can write `Let's consider all cases for b` to split into the two possible cases, and then announce each case: `Let's first consider the case where b is false` and later `Let's next consider the case where b is true`. Because every case is announced, you always know which one you are working on.

Alternatively, you can define the entire function at once in one line, with Lean's syntax for definitions by cases: `Let's use fun b ↦ match b with | false => ? | true => ?` where each `?` should be replaced by the appropriate element of `Bool`.

Note this level comes with two pre-defined goals: the first is to define the negation function `Bool → Bool` and the second is to check that your definition is correct by calculating the values of the function you defined on the booleans `true` and `false`.
"

/-- The negation function `not : Bool → Bool` sends the boolean `false` to `true` and `true` to `false`. -/
Statement (preamble := refine let f := ?f; ⟨f, ?eq⟩) :
  ∃ f : Bool → Bool, f true = false ∧ f false = true := by
  Hint "Your first objective is to define the negation function. Write `Fix b : Bool`."
  Fix b : Bool
  Hint (hidden := true) "Write `Let's consider all cases for {b}`, then announce a case, e.g. `Let's first consider the case where {b} is false`."
  Let's consider all cases for b
  Let's first consider the case where b is false
  Hint (hidden := true) "Which boolean should the negation of `false` be? Write `Let's use ??`."
  Let's use true
  Let's next consider the case where b is true
  Let's use false
  Hint "Now you are asked to check that the function `f : Bool → Bool` that you just defined actually *is* the negation function. Specifically, you are asked to check that `f true = false ∧ f false = true`. Both halves hold by definition: `Let's first prove that f true = false`, `We conclude by rfl`, and so on; or in one go, `We conclude by ⟨rfl, rfl⟩`."
  Let's first prove that f true = false
  We conclude by rfl
  Let's now prove that f false = true
  We conclude by rfl

Conclusion "Lean has a built in name `not` for this function. It is now in your library."

/-- The type `Bool` is the type of booleans. It contains two elements, denoted `false` and `true`. -/
DefinitionDoc Bool as "Bool" in "Type"

/-- The negation function `Bool.not : Bool → Bool` sends the boolean `false` to `true` and `true` to `false`. -/
DefinitionDoc Bool.not as "not" in "Bool"

/-- There is an element of type `Bool` called `Bool.false`. -/
DefinitionDoc Bool.false as "false" in "Bool"

/-- There is an element of type `Bool` called `Bool.true`. -/
DefinitionDoc Bool.true as "true" in "Bool"

NewDefinition Bool Bool.not Bool.false Bool.true

/-- `match` is Lean's keyword for definitions by cases inside an element: `fun b ↦ match b with | false => … | true => …` defines a function on `Bool` by giving its two values. It is not a sentence of its own; it appears inside `Let's use …` or `Set f := …`. -/
TacticDoc «match»

NewHiddenTactic «match»
