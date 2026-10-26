import Game.Levels.DisjunctionWorld.L05_UniversalProperty

World "DisjunctionWorld"
Level 6

Title "Associativity"

Introduction "Similarly, for propositions `P`, `Q`, and `R`, `(P ∨ Q) ∨ R` holds if and only if `P ∨ (Q ∨ R)` holds.

Similarly to the conventions used for products, conjunctions, and coproducts, Lean uses `P ∨ Q ∨ R` as an abbreviation for `P ∨ (Q ∨ R)`.

Given a hypothesis `h₁ : (P ∨ Q) ∨ R`, `Let's consider all cases for h₁` will split the hypothesis into two cases: one assuming that `P ∨ Q` is true and the other assuming `R` is true. The first of these, announced with `Let's first consider the case where h₁ is inl hpq`, provides a hypothesis `hpq : P ∨ Q` whose cases can be considered in turn.

Similarly given a hypothesis `h₂ : P ∨ Q ∨ R`, its two cases assume that `P` is true, respectively that `Q ∨ R` is true.

Aside: Typing `\\7` using any single digit number produces a subscript with that number, like `₇`. You can use this if you'd like to use numerical subscripts in your variable names.
"

/-- Or is associative: `(P ∨ Q) ∨ R` is true if and only if `P ∨ (Q ∨ R)` is true.-/
Statement {P Q R : Prop} : (P ∨ Q) ∨ R ↔ P ∨ Q ∨ R := by
  Hint (hidden := true) "What is the outermost logical connective?"
  Let's first prove that (P ∨ Q) ∨ R → P ∨ Q ∨ R
  Assume hpqr : (P ∨ Q) ∨ R
  Hint (hidden := true) "Split your hypothesis into cases: `Let's first consider the case where {hpqr} is inl hpq`."
  Let's first consider the case where hpqr is inl hpq
  Hint (hidden := true) "The hypothesis `{hpq}` isn't directly usable yet. Consider its cases too: `Let's first consider the case where {hpq} is inl hp`."
  Let's first consider the case where hpq is inl hp
  Let's prove that P
  We conclude by hp
  Let's next consider the case where hpq is inr hq
  Hint (hidden := true) "Here the goal is parenthesized as `{P} ∨ ({Q} ∨ {R})`. Using your hypothesis, are you trying to prove the left-hand proposition or the right-hand one?"
  Let's prove that Q ∨ R
  Let's prove that Q
  We conclude by hq
  Let's next consider the case where hpqr is inr hr
  Hint (hidden := true) "Here the goal is parenthesized as `{P} ∨ ({Q} ∨ {R})`. Using your hypothesis, are you trying to prove the left-hand proposition or the right-hand one?"
  We conclude by Or.inr (Or.inr hr)
  Let's now prove that P ∨ Q ∨ R → (P ∨ Q) ∨ R
  Assume hpqr : P ∨ Q ∨ R
  Let's first consider the case where hpqr is inl hp
  We conclude by Or.inl (Or.inl hp)
  Let's next consider the case where hpqr is inr hqr
  Hint (hidden := true) "The hypothesis `{hqr}` isn't directly usable yet. Consider its cases: `Let's first consider the case where {hqr} is inl hq`."
  Let's first consider the case where hqr is inl hq
  We conclude by Or.inl (Or.inr hq)
  Let's next consider the case where hqr is inr hr
  We conclude by Or.inr hr

Conclusion "This proves the associativity of disjunction.
"
