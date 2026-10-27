import Game.Levels.DisjunctionWorld.L06_Associativity

World "DisjunctionWorld"
Level 7

Title "Distributivity"

Introduction "What does it mean if `P ∧ (Q ∨ R)` holds?

Then certainly `P` is true and also `Q ∨ R` is true.

So we can conclude that `P ∧ Q` is true or `P ∧ R` is true, demonstrating one of the implications in the following logical equivalence."

/-- Conjunction distributes over disjunction: `P ∧ (Q ∨ R)` and `(P ∧ Q) ∨ (P ∧ R)` are logically equivalent. -/
Statement {P Q R : Prop} : P ∧ (Q ∨ R) ↔ (P ∧ Q) ∨ (P ∧ R) := by
  Hint (hidden := true) "What is the outermost logical connective?"
  Let's first prove that P ∧ (Q ∨ R) → (P ∧ Q) ∨ (P ∧ R)
  Hint (hidden := true) "What is the outermost logical connective?"
  Assume h : P ∧ (Q ∨ R)
  Hint (hidden := true) "Recall that `{h}.1 : {P}` and `{h}.2 : {Q} ∨ {R}`. Name them with `By {h} we get p : {P} and qr : {Q} ∨ {R}`, so that you can consider the cases of `qr`."
  By h we get p : P and qr : Q ∨ R
  Let's first consider the case where qr is inl q
  Let's prove that P ∧ Q
  We conclude by ⟨p, q⟩
  Let's next consider the case where qr is inr r
  Let's prove that P ∧ R
  We conclude by ⟨p, r⟩
  Let's now prove that (P ∧ Q) ∨ (P ∧ R) → P ∧ (Q ∨ R)
  Assume h : (P ∧ Q) ∨ (P ∧ R)
  Let's first consider the case where h is inl pq
  Let's first prove that P
  We conclude by pq.1
  Let's now prove that Q ∨ R
  Let's prove that Q
  We conclude by pq.2
  Let's next consider the case where h is inr pr
  We conclude by ⟨pr.1, Or.inr pr.2⟩

Conclusion "This proves that conjunction distributes over disjunction. A more involved form of distributivity appears in the next level."
