import Game.Levels.ClassicalWorld.L03_ExcludedMiddle

World "ClassicalWorld"
Level 4

Title "Negating Conjunction"

Introduction "We have seen that `¬ P ∨ ¬ Q` implies `¬ (P ∧ Q)`.

But we were not able to prove constructively that `¬ (P ∧ Q)` implies `¬ P ∨ ¬ Q`, since we cannot tell whether `P` or `Q` is the false proposition.

However, we can prove this using classical logic.

Recall that in classical logic, we may assume the *law of excluded middle*, i.e., that `P ∨ ¬ P` is true for any proposition.

In particular, in the middle of your proof, you can write `Fact lem : P ∨ ¬ P from Classical.em P` to introduce `P ∨ ¬ P` as a hypothesis.

Can you use this to prove the desired implication?
"

section
open Classical

/-- In classical logic, `¬ (P ∧ Q)` implies `¬ P ∨ ¬ Q`. -/
Statement {P Q : Prop} : ¬ (P ∧ Q) → ¬ P ∨ ¬ Q := by
  Hint (hidden := true) "What is the outermost logical connective?"
  Assume npq : ¬ (P ∧ Q)
  Hint (hidden := true) "Write `Fact lem : P ∨ ¬ P from Classical.em P` to appeal to the law of excluded middle for `P`. Alternatively, you can appeal to the law of excluded middle for `Q` or for any other proposition."
  Branch
    Fact lem : Q ∨ ¬ Q from Classical.em Q
    Hint (hidden := true) "Now might be a good time to consider the cases of the hypothesis `{lem}`."
    Let's first consider the case where lem is inl q
    Hint (hidden := true) "Because  `{q} : Q`, it is unlikely that you will be able to prove `¬ Q`. So instead try to prove `¬ P`: announce it with `Let's prove that ¬ P`."
    Let's prove that ¬ P
    Assume p : P
    We conclude by npq applied to ⟨p, q⟩
    Let's next consider the case where lem is inr nq
    Let's prove that ¬ Q
    We conclude by nq
  Fact lem : P ∨ ¬ P from Classical.em P
  Hint (hidden := true) "Now might be a good time to consider the cases of the hypothesis `lem`."
  Let's first consider the case where lem is inl p
  Hint (hidden := true) "Because  `{p} : P`, it is unlikely that you will be able to prove `¬ P`. So instead try to prove `¬ Q`: announce it with `Let's prove that ¬ Q`."
  Let's prove that ¬ Q
  Assume nq : Q
  Hint (hidden := true) "What can you prove with `{p}` and `{nq}`?"
  Hint (hidden := true) "Try `Fact pq : P ∧ Q from ⟨{p}, {nq}⟩` or try `We apply {npq}`."
  Fact pq : P ∧ Q from ⟨p, nq⟩
  We apply npq
  We conclude by pq
  Let's next consider the case where lem is inr np
  We conclude by Or.inl np

end

Conclusion "Combined with what we know already, we have established a logical equivalence between  `¬ (P ∧ Q)` and `¬ P ∧ ¬ Q` in classical logic."
