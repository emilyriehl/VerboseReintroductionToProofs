import Game.Levels.CoproductWorld.L06_Associativity

World "CoproductWorld"
Level 7

Title "Distributivity"


Introduction "How should we think about an element of type `x : A × (B ⊕ C)`?.

Since `x` belongs to a product type, it can be split into two components. That is `x` has the form of a pair `⟨y, z⟩` with `y : A` and `z : B ⊕ C`. And since `z` belongs to a coproduct type, there are two possible cases: it can have the form `Sum.inl b` for some `b : B` or it can have the form `Sum.inr c` for some `c : C`. In the first case, the original `x : A × (B ⊕ C)` is a pair of the form `⟨y, Sum.inl b⟩` coming from `⟨y, b⟩ : A × B` which in the second case `x` is a pair of the form `⟨y, Sum.inr c⟩` coming from `⟨y, c⟩ : A × C`.

This explains the *distributivity* of products over coproducts, which can be encoded by a pair of functions, one of the form `A × (B ⊕ C) → (A × B) ⊕ (A × C)` and the other of the form `(A × B) ⊕ (A × C) → A × (B ⊕ C)`.

Your challenge in this level is to define these functions.

While it may be complicated to think about the entire construction at once, you can use the context and goal types at each stage of the construction to help guide you.

The introduction rules and their associated sentences can be used to transform the goal state into simpler goal states. Simultaneously, the elimination rules can be used to define new elements out of any elements that appear in your context of objects.
"

/-- For types `A`, `B`, and `C`, there are canonical functions between the types `A × (B ⊕ C)` and `(A × B) ⊕ (A × C)`. -/
Statement {A B C : Type} : (A × (B ⊕ C) → (A × B) ⊕ (A × C)) × ((A × B) ⊕ (A × C) → A × (B ⊕ C)) := by
  Hint (hidden := true) "The goal is a product of function types, so to define an element you need to define two different functions. Each will take some work, so start with `Let's construct the pair` to split one goal into two goals."
  Let's construct the pair
  Hint (hidden := true) "Now the goal is a function type. Which sentence is used to define functions?"
  Fix p : A × (B ⊕ C)
  Hint (hidden := true) "First take the pair `{p}` apart with `By {p} we get a : A and z : B ⊕ C`, then consider the cases for `z`."
  By p we get a : A and z : B ⊕ C
  Let's first consider the case where z is inl b
  Let's construct an element of A × B
  Let's use ⟨a, b⟩
  Let's next consider the case where z is inr c
  Let's construct an element of A × C
  Let's use ⟨a, c⟩
  Hint (hidden := true) "Now the goal is a function type. Which sentence is used to define functions?"
  Fix p : (A × B) ⊕ (A × C)
  Let's first consider the case where p is inl q
  Let's use ⟨q.1, Sum.inl q.2⟩
  Let's next consider the case where p is inr r
  Let's use ⟨r.1, Sum.inr r.2⟩

Conclusion "You might enjoy solving this level again without taking the pair apart first: the projections `p.1 : A` and `p.2 : B ⊕ C` are always available, and `Set z := p.2` followed by `Let's consider all cases for z` also works."
