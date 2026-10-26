import Game.Levels.EquivalenceWorld.L03_SwappingInputs

World "EquivalenceWorld"
Level 4

Title "Currying / Uncurrying"

Introduction "*Currying* is the operation that converts a function of type `A × B → C` into a function of type `A → B → C`.

*Uncurrying* is the operation that converts a function of type `A → B → C` into a function of type `A × B → C`.

These operations are inverses, defining an equivalence of types

`(A × B → C) ≃ (A → B → C)`.

Note the currying and uncurrying functions are in the library, so can be used (rather than re-defined) in the proof.
"

open ReintroductionToProofs

/-- For any types `A`, `B`, and `C`, the function types `A × B → C` and `A → B → C` are equivalent. -/
Statement {A B C : Type} : (A × B → C) ≃ (A → B → C) := by
  Hint (hidden := true) "Write `Let's construct it componentwise` to split the goal up into the four proof obligations."
  Let's construct it componentwise
  Hint (hidden := true) "This function is in the library. Rather than redefine it, can you use it?"
  Let's use Function.curry
  Hint (hidden := true) "This function is in the library. Rather than redefine it, can you use it?"
  Let's use Function.uncurry
  Fix f : A × B → C
  We conclude by rfl
  Fix f : A → B → C
  We conclude by rfl

Conclusion "Note this level can be solved in one line with
`Let's use ⟨Function.curry, Function.uncurry, fun f ↦ rfl, fun f ↦ rfl⟩`. Can you make sense of this proof?"
