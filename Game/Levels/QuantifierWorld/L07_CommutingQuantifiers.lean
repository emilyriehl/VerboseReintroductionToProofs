import Game.Levels.QuantifierWorld.L06_MultipleQuantifiers

World "QuantifierWorld"
Level 7

Title "Commuting Quantifiers"

Introduction "Consider a family of propositions that depends on elements drawn from two separate types:

`P : A → B → Prop`

In this level, we will compare the two statements

`∀ x : A, ∃ y : B, P x y` and
`∃ z : B, ∀ w : A, P w z`.

We will see that the second statement implies the first.

The converse implication is not true in general. Can you see why?

To solve this level, you will need to use a hypothesis involving an existential quantifier,
which in this case will have the form:

`h : ∃ z : B, ∀ w : A, P w z`

We would like to decompose the hypothesis `h` into a pair of elements: firstly an element `b : B`
and secondly a proof `hb : ∀ w : A, P w b`. Note that the element `b` gets substituted for the variable `z` in the family of propositions `∀ w : A, P w z`.

We can think of the proof `h` as being given by this pair of data `⟨b, hb⟩ : ∃ z : B, ∀ w : A, P w z`. Indeed `h = ⟨b, hb⟩`.

To extract this data from the proof `h`, write `By h we get b such that hb : ∀ w : A, P w b`, which adds the assumptions `b : B` and `hb : ∀ w : A, P w b` to your context. (You may also leave the fact unnamed, `By h we get b such that ∀ w : A, P w b`, and Lean names it for you.)
"

/-- Given a family of propositions `P : A → B → Prop`, `∃ z : B, ∀ w : A, P w z`implies `∀ x : A, ∃ y : B, P x y` -/
Statement {A B : Type} (P : A → B → Prop) : (∃ z : B, ∀ w : A, P w z) → ∀ x : A, ∃ y : B, P x y := by
  Assume h : ∃ z : B, ∀ w : A, P w z
  Fix a : A
  Hint (hidden := true) "Write `By {h} we get b such that hb : ∀ w : A, P w b` to extract the pair of assumptions `b : B` and
  `hb : ∀ w : A, P w b` from `{h}`."
  By h we get b such that hb : ∀ w : A, P w b
  Let's prove that b works
  We conclude by hb applied to a

Conclusion "In the next levels, we will study the effect of negating existential and universal quantifiers."
