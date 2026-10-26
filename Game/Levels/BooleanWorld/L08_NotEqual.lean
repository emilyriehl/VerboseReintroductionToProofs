import Game.Levels.BooleanWorld.L07_DeMorgan

World "BooleanWorld"
Level 8

Title "Not Equal"

Introduction "We will now finally prove an example that two elements of a type are distinct, demonstrating that
the two booleans are not equal:

`¬ (false = true)`.

The proof is quite delicate, so let us explain how it works.

We are asked to prove a negation so suppose we have `p : false = true`. We would like to derive a contradiction, that is an element of `False`.

The key ingredient is to use a function `P : Bool → Prop` defined to send the boolean `false` to the proposition `False` and the boolean `true` to the proposition `True`.

Using this we can define a function `True → False`, i.e., a function `P true → P false` by introduction a hypothesis `x : P true` then rewriting along the equality `p` to change the goal from `P false` to `P true`, then returning `x : P true`.

Applying this function to the element `⟨⟩ : True` returns an element of `False`, a contradiction.

Use the hints to step through this proof.

Alternatively, write `We conclude by Bool.noConfusion` to solve this level with Lean's built in proof that `¬ (false = true)`.
"

/-- The elements `false : Bool` and `true : Bool` are not equal. -/
Statement : ¬ (false = true) := by
  Hint (hidden := true) "Start with `Assume p : false = true`."
  Assume p : false = true
  Hint (strict:=true) (hidden := true) "Define a function `Bool → Prop` by `Set P : Bool → Prop := fun b ↦ match b with | false => False | true => True`."
  Set P : Bool → Prop := fun b ↦ match b with | false => False | true => True
  Hint (strict:=true) (hidden := true) "Establish `P true → P false` by `Fact tr : P true → P false by Assume x : P true; We rewrite using p; We conclude by x`. In editor mode, start with `Fact tr : P true → P false by` then continue with each of the three sentences on three subsequent indented lines. This way you can see how the goal evolves with each step in the construction."
  Fact tr : P true → P false by Assume x : P true; We rewrite using p; We conclude by x
  Hint (hidden := true) "By the definition of the family of propositions `P : Bool → Prop`, the function `tr : P true → P false` is a function `tr : True → False`. In particular, if we apply `tr` to an element of `True`, we get an element of `False`, which is what we want."
  Hint (hidden := true) "Write `We conclude by tr applied to ⟨⟩` to return an element of `False` defined using the function `tr` and the element `⟨⟩ : True`."
  We conclude by tr applied to ⟨⟩

Conclusion "We have added the theorem `Bool.noConfusion` to the library."

/-- `Bool.noConfusion` proves `¬ (false = true)` or `¬ (true = false)` for booleans. -/
TheoremDoc Bool.noConfusion as "noConfusion" in "Bool"

NewTheorem Bool.noConfusion
