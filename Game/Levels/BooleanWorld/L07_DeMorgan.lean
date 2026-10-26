import Game.Levels.BooleanWorld.L06_DisjunctionSymmetry

World "BooleanWorld"
Level 7

Title "DeMorgan"

Introduction "The DeMorgan laws for booleans take the form of equalities

`not (Bool.and x y) = Bool.or (not x) (not y)` and

`not (Bool.or x y) = Bool.and (not x) (not y)`

for all booleans `x y : Bool`.

In Lean's notation the first equality is

`!(x && y) = !x || !y`

while the second equality is

`!(x || y) = !x && !y`.

The objective of this level is to prove these equalities.
"

/-- The DeMorgan equalities relate the operations of conjunction, disjunction, and negation on booleans. -/
Statement (x y : Bool) : (not (Bool.and x y) = Bool.or (not x) (not y)) ∧ (not (Bool.or x y) = Bool.and (not x) (not y)) := by
  Hint (hidden := true) "Consider the cases for `{x}` and `{y}` first; in each of the four cases both equalities hold by definition, so `We conclude by ⟨rfl, rfl⟩` finishes the case."
  Let's first consider the case where x is false
  Let's first consider the case where y is false
  We conclude by ⟨rfl, rfl⟩
  Let's next consider the case where y is true
  We conclude by ⟨rfl, rfl⟩
  Let's next consider the case where x is true
  Let's first consider the case where y is false
  We conclude by ⟨rfl, rfl⟩
  Let's next consider the case where y is true
  We conclude by ⟨rfl, rfl⟩

Conclusion "Can you figure out how you would encode other logical equivalences involving proposition variables as equalities involving booleans?"
