import Game.Levels.QuantifierWorld.L03_UniversalElimination

World "QuantifierWorld"
Level 4

Title "Introducing Existence"

Introduction "Let `P : A → Prop` be a predicate over a type `A`.

To prove the proposition `∃ x : A, P x` it suffices to find any element `a : A` so that `P a` holds.

If you have a proof `p_a : P a`, then the same notation used for conjunctions and product types can be used to define an element `⟨a, p_a⟩ : ∃ x : A, P x`. In this game you usually proceed in two steps instead: announce the witness with `Let's prove that a works`, and then prove `P a`.

Here the element `⟨a, p_a⟩` can be thought of as a *dependent pair*, where the type `P a` of the right component `p_a : P a` depends on the left component `a : A`.

Recall the function `and : Bool → Bool → Bool` capturing the logical notion of conjunction. Lean uses alternate notation `x && y = and x y`.

Recall also the function `or : Bool → Bool → Bool` capturing the logical notion of disjunction. Lean uses the alternate notation `x || y = or x y`

In this level, you are asked to prove that there exists some boolean `b : Bool` so that `b && b = b || b`.

If the goal is to prove `∃ x : A, P x`, write `Let's prove that a works` referencing a specific element `a : A` to reduce the goal to proving `P a`.
"

/-- There is some boolean `b` so that `b && b = b || b` -/
Statement : ∃ b : Bool, (b && b) = (b || b) := by
  Hint "Write `Let's prove that ?? works` with the name of an element of `Bool` that you believe will satisfy the predicate in place of `??`."
  Let's prove that false works
  Hint "Now you are asked to prove a special case of the indexed family of propositions, where the indexing element `b` is specialized to the element you provided. Both sides compute to the same boolean, so `We conclude by rfl`."
  We conclude by rfl

Conclusion "The next level will give more practice with the existential quantifier."


-- (the word `use` is declared game-wide in TypeWorld level 1)

/--
For a family of propositions `P : A → Prop`, `∃ x : A, P x` is the proposition that asserts that there is some element `a : A` so that `P a` is true. An element of `∃ x : A, P x` may be thought of as a *dependent pair* `⟨a, p_a⟩` where the first component specifies an element `a : A` while the second component specifies a proof `p_a : P a` of the corresponding proposition `P a`.
-/
DefinitionDoc «∃» as "∃" in "Logic"

NewDefinition «∃»
