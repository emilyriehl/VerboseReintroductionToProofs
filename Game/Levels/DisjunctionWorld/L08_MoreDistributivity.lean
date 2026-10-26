import Game.Levels.DisjunctionWorld.L07_Distributivity

World "DisjunctionWorld"
Level 8

Title "More Distributivity"

Introduction "A more involved form of distributivity is also true.

If `P ∨ Q` holds and `R ∨ S` holds then at least one of the following four propositions holds: `P ∧ R` or `P ∧ S` or `Q ∧ R` or `Q ∧ S`.

Conversely, if either of these four conjunctions holds, then `P ∨ Q` holds and `R ∨ S` holds.

Demonstrate the following logical equivalence."

/-- `(P ∨ Q) ∧ (R ∨ S)` holds if and only if `(P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S)` holds. -/
Statement {P Q R S : Prop} : (P ∨ Q) ∧ (R ∨ S) ↔ (P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S) := by
  Hint (hidden := true) "What is the outermost logical connective?"
  Let's first prove that (P ∨ Q) ∧ (R ∨ S) → (P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S)
  Assume h : (P ∨ Q) ∧ (R ∨ S)
  Hint (hidden := true) "What can you conclude from the hypothesis `{h}`?"
  Hint (hidden := true) "Write `By {h} we get pq : P ∨ Q and rs : R ∨ S` to break apart the hypothesis `{h}`; then consider the cases of `pq`, and inside each of them the cases of `rs`."
  By h we get pq : P ∨ Q and rs : R ∨ S
  Let's first consider the case where pq is inl p
  Let's first consider the case where rs is inl r
  Hint (hidden := true) "The implicit parentheses in the goal are to the right `(P ∧ R) ∨ ((P ∧ S) ∨ ((Q ∧ R) ∨ (Q ∧ S)))`."
  Hint (hidden := true) "Thus the outermost logical connective is the `∨` combining `P ∧ R` and `(P ∧ S) ∨ ((Q ∧ R) ∨ (Q ∧ S))`."
  Let's prove that P ∧ R
  We conclude by ⟨p, r⟩
  Let's next consider the case where rs is inr s
  Let's prove that (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S)
  Let's prove that P ∧ S
  We conclude by ⟨p, s⟩
  Hint (hidden := true) "This completes the proof in the case where `P ∨ Q` holds because `P` holds. Now announce the case where `Q` holds, which requires another case split over the proof `rs : {R} ∨ {S}`."
  Let's next consider the case where pq is inr q
  Let's first consider the case where rs is inl r
  We conclude by Or.inr (Or.inr (Or.inl ⟨q, r⟩))
  Let's next consider the case where rs is inr s
  We conclude by Or.inr (Or.inr (Or.inr ⟨q, s⟩))
  Let's now prove that (P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S) → (P ∨ Q) ∧ (R ∨ S)
  Assume h : (P ∧ R) ∨ (P ∧ S) ∨ (Q ∧ R) ∨ (Q ∧ S)
  Hint (hidden := true) "Consider the cases of `{h}`, one after the other: `Let's first consider the case where {h} is inl pr`, and the remaining disjunction in the `inr` case splits further."
  Let's first consider the case where h is inl pr
  We conclude by ⟨Or.inl pr.1, Or.inl pr.2⟩
  Let's next consider the case where h is inr h'
  Let's first consider the case where h' is inl ps
  We conclude by ⟨Or.inl ps.1, Or.inr ps.2⟩
  Let's next consider the case where h' is inr h''
  Let's first consider the case where h'' is inl qr
  We conclude by ⟨Or.inr qr.1, Or.inl qr.2⟩
  Let's next consider the case where h'' is inr qs
  We conclude by ⟨Or.inr qs.1, Or.inr qs.2⟩

Conclusion "We are now ready for the Boss Level of Disjunction World."
