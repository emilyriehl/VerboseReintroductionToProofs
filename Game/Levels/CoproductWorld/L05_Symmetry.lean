import Game.Levels.CoproductWorld.L04_UniversalProperty

World "CoproductWorld"
Level 5

Title "Symmetry"

Introduction "The coproduct type, like the product type, is *symmetric*, and in particular has a canonical map of type `A ⊕ B → B ⊕ A`. Your task in this level is to define it.

Use the elimination rule for coproduct types and the associated sentences (`Let's consider all cases for x`, `Let's first consider the case where x is inl a`, …) to map out of the type `A ⊕ B`.

Then use the introduction rules for coproduct types and the associated sentence `Let's construct an element of …` to map into the type `B ⊕ A`.
"

/-- For any types `A` and `B`, there is a canonical function of type `A ⊕ B → B ⊕ A`. -/
Statement {A B : Type} : A ⊕ B → B ⊕ A := by
  Hint (hidden := true) "Use `Fix` to define a term in a function type."
  Fix x : A ⊕ B
  Hint (hidden := true) "Consider the possible cases for the variable `{x} : A ⊕ B`, starting with `Let's first consider the case where {x} is inl a`."
  Let's first consider the case where x is inl a
  Hint (hidden := true) "Which side of `B ⊕ A` can you construct an element of?"
  Let's construct an element of A
  Let's use a
  Let's next consider the case where x is inr b
  Hint (hidden := true) "Which side of `B ⊕ A` can you construct an element of?"
  Let's construct an element of B
  Let's use b


Conclusion "The same construction defines a function of type `B ⊕ A → A ⊕ B`, demonstrating the symmetry of the coproduct."

/--
For types `A` and `B`, the function `Sum.swap : A ⊕ B → B ⊕ A` is defined to send elements of the form `Sum.inl a` to `Sum.inr a` and elements of the form `Sum.inr b` to `Sum.inl b`.
-/
DefinitionDoc Sum.swap as "swap" in "Sum"

NewDefinition Sum.swap
