import Game.Levels.NegationWorld.L07_NegatingImplication

World "NegationWorld"
Level 8

Title "Negating Disjunction"

Introduction "In this level, we will study the proposition `¬ (P ∨ Q)`.

How would we disprove the implication `P ∨ Q`?

What does it mean for `P ∨ Q` to be false?

Recall, if `P` is true, then we can prove `P ∨ Q`. Similarly, if `Q` is true, we can prove `P ∨ Q`.

So if `P ∨ Q` is false, then both `P` and `Q` must be false.

In this level, we will show that `¬ (P ∨ Q)` is logically equivalent to `¬ P ∧ ¬ Q`.

If you have forgotten the meaning of logical equivalence, denoted `⇔`, you can look it up in the library.
"

/-- For any propositions `P` and `Q`, the propositions `¬ (P ∨ Q)` and `¬ P ∧ ¬ Q` are logically equivalent. -/
Statement {P Q : Prop} : ¬ (P ∨ Q) ↔ ¬ P ∧ ¬ Q := by
  Hint (hidden := true) "Here the `⇔` is the outermost logical connective. If you've forgotten what this means, you can look it up in the library."
  Let's first prove that ¬ (P ∨ Q) → ¬ P ∧ ¬ Q
  Assume nor : ¬ (P ∨ Q)
  Hint (hidden := true) "Here the `∧` is the outermost logical connective. How do you prove conjunctions?"
  Let's first prove that ¬ P
  Assume p : P
  Hint (hidden := true) "What can you do with the hypothesis `{nor}`?"
  We apply nor
  Hint (hidden := true) "Announce which side of the disjunction you can prove."
  Let's prove that P
  We conclude by p
  Let's now prove that ¬ Q
  Assume q : Q
  Hint (hidden := true) "What can you do with the hypothesis `{nor}`?"
  We apply nor
  Let's prove that Q
  We conclude by q
  Let's now prove that ¬ P ∧ ¬ Q → ¬ (P ∨ Q)
  Assume andn : ¬ P ∧ ¬ Q
  Assume pq : P ∨ Q
  Let's first consider the case where pq is inl p
  Hint (hidden := true) "What proofs can you extract from the hypothesis `{andn}`?"
  We conclude by andn.1 applied to p
  Let's next consider the case where pq is inr q
  We conclude by andn.2 applied to q

Conclusion "Have another look at Level 5 of Disjunction World, discussing the universal property of disjunction. How are these statements related?"
