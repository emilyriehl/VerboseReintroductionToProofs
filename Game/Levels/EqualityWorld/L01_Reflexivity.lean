import Game.Levels.EmptyWorld
import Game.Levels.ImplicationWorld

World "EqualityWorld"
Level 1

Title "Reflexivity"

Introduction "Let `A` be a type with an element `a : A`. Then the proposition `a = a` is always true
because there is a proof `rfl : a = a` witnessing the *reflexivity* of equality.

In Lean, `rfl` is a name for an element of the type `a = a`. So to produce a proof of `a = a`, you
write `We conclude by rfl`. The same sentence proves any equation whose two sides are equal *by definition*, as the next levels illustrate.
"

/--
For a type `A` and element `a : A`, the proposition `a = a` is true because there is a proof
`rfl : a = a` witnessing the reflexivity of equality.
-/
TheoremDoc rfl as "rfl" in "Eq"

/-- For any element `a : A`, `a = a` is true by reflexivity.-/
Statement {A : Type} {a : A} : a = a := by
  We conclude by rfl

NewTheorem rfl

Conclusion "In summary, a basic axiom of equality is *reflexivity*:
for any `a : A`, `a = a` is always true."
