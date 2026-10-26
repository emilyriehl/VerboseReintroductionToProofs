import Game.Levels.CoproductWorld.L05_Symmetry

World "CoproductWorld"
Level 6

Title "Associativity"


Introduction "Given three types `A`, `B`, and `C`, the coproduct type construction may be iterated to define types `(A ⊕ B) ⊕ C` and `A ⊕ (B ⊕ C)`.

For both of these types, there are three cases of elements: those coming from `a : A`, those coming from `b : B`, and those coming from `c : C`. The notation for the corresponding elements of the iterated coproduct type depends on the parentheses: the terms `b : B` include as `Sum.inl (Sum.inr b) : (A ⊕ B) ⊕ C` but include as `Sum.inr (Sum.inl b) : A ⊕ (B ⊕ C)`.

The objective in this level is to define a pair of functions between these types in each direction, the first of type `((A ⊕ B) ⊕ C) → (A ⊕ (B ⊕ C))` and the second of type `(A ⊕ (B ⊕ C)) → ((A ⊕ B) ⊕ C)`. That is, define a single element of type

`(((A ⊕ B) ⊕ C) → (A ⊕ (B ⊕ C))) × ((A ⊕ (B ⊕ C)) → ((A ⊕ B) ⊕ C))`

By convention, the notation `A ⊕ B ⊕ C` is an abbreviation for the coproduct type `A ⊕ (B ⊕ C)`. For an element `x : A ⊕ B ⊕ C`, the case `x is inr y` yields an element `y : B ⊕ C`, which can itself be split into cases with `Let's consider all cases for y`: three cases in total, corresponding to elements `a : A`, `b : B`, or `c : C`.

Similarly, for an element `y : (A ⊕ B) ⊕ C`, the case `y is inl z` yields `z : A ⊕ B`, which splits further.
"

/-- For types `A`, `B`, and `C`, there are canonical functions between the types `(A ⊕ B) ⊕ C` and `A ⊕ (B ⊕ C)`. -/
Statement {A B C : Type} : (((A ⊕ B) ⊕ C) → (A ⊕ (B ⊕ C))) × ((A ⊕ (B ⊕ C)) → ((A ⊕ B) ⊕ C)) := by
  Hint (hidden := true) "The goal is a product of function types, so to define an element you need to define two different functions. Each will take some work, so start with `Let's construct the pair` to split one goal into two goals."
  Let's construct the pair
  Hint (hidden := true) "Now the goal is a function type. Which sentence is used to define functions?"
  Fix p : (A ⊕ B) ⊕ C
  Hint (hidden := true) "Split into cases: `Let's first consider the case where {p} is inl y` and later `Let's next consider the case where {p} is inr c`."
  Let's first consider the case where p is inl y
  Hint (hidden := true) "`{y}` is itself an element of a coproduct type, so consider its cases too."
  Let's first consider the case where y is inl a
  Let's construct an element of A
  Let's use a
  Let's next consider the case where y is inr b
  Let's construct an element of B ⊕ C
  Let's construct an element of B
  Let's use b
  Let's next consider the case where p is inr c
  Let's construct an element of B ⊕ C
  Let's construct an element of C
  Let's use c
  Fix p : A ⊕ (B ⊕ C)
  Hint (hidden := true) "Split into cases: `Let's first consider the case where {p} is inl a` and later `Let's next consider the case where {p} is inr y`."
  Let's first consider the case where p is inl a
  Let's construct an element of A ⊕ B
  Let's construct an element of A
  Let's use a
  Let's next consider the case where p is inr y
  Let's first consider the case where y is inl b
  Let's construct an element of A ⊕ B
  Let's construct an element of B
  Let's use b
  Let's next consider the case where y is inr c
  Let's construct an element of C
  Let's use c

Conclusion "Next we will study the relationship between products and coproducts."
