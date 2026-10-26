import Game.Levels.ConjunctionWorld.L04_LogicalEquivalence

World "ConjunctionWorld"
Level 5

Title "Associativity"

Introduction "For propositions `P`, `Q`, and `R`, `(P ∧ Q) ∧ R` is true if and only if `P ∧ (Q ∧ R)` is true.

Lean likes to drop parentheses whenever possible so uses `P ∧ Q ∧ R` as an abbreviation for `P ∧ (Q ∧ R)`. While it's difficult to remember this convention, at least the two possible statements are logically equivalent!

Given a proof `h : (P ∧ Q) ∧ R`, we obtain proofs `h.1 : P ∧ Q` and `h.2 : R`. From the first of these,
we obtain further proofs `h.1.1 : P` and `h.1.2 : Q`.

A proof `k : P ∧ (Q ∧ R)` can be decomposed similarly, using different notation. Now we have proofs `k.1 : P` and `k.2 : Q ∧ R` and the latter proof decomposes further as `k.2.1 : Q` and `k.2.2 : R`.

Similarly, given proofs `p : P`, `q : Q`, `r : R`, then `⟨⟨p, q⟩, r⟩ : (P ∧ Q) ∧ R` while `⟨p, ⟨q, r⟩⟩ : P ∧ (Q ∧ R)` are proofs of the triple conjunction. Lean allows the shorthand `⟨p, q, r⟩ : P ∧ Q ∧ R` for the latter proof.

Your goal in this level is to prove the associativity of conjunction.
"

/-- Conjunction is associative: `(P ∧ Q) ∧ R` is true if and only if `P ∧ (Q ∧ R)` is true. -/
Statement {P Q R : Prop} : (P ∧ Q) ∧ R ↔ P ∧ (Q ∧ R) := by
  Let's first prove that (P ∧ Q) ∧ R → P ∧ (Q ∧ R)
  Assume h : (P ∧ Q) ∧ R
  Let's first prove that P
  Hint (hidden := true) "Think carefully about what `{h}` proves and what proofs can be extracted from this."
  Hint (hidden := true) "Note the `.1` and `.2` notation can be iterated."
  We conclude by h.1.1
  Hint (hidden := true) "Announce the remaining goal, then break it into subgoals again."
  Let's now prove that Q ∧ R
  Let's first prove that Q
  We conclude by h.1.2
  Let's now prove that R
  We conclude by h.2
  Let's now prove that P ∧ (Q ∧ R) → (P ∧ Q) ∧ R
  Assume k : P ∧ (Q ∧ R)
  Hint (hidden := true) "Which sentence breaks a goal involving conjunction into subgoals?"
  Let's first prove that P ∧ Q
  Hint (hidden := true) "Which sentence breaks a goal involving conjunction into subgoals?"
  Let's first prove that P
  Hint (hidden := true) "Think carefully about what `{k}` proves and what proofs can be extracted from this."
  We conclude by k.1
  Hint (hidden := true) "Note the `.1` and `.2` notation can be iterated."
  Let's now prove that Q
  We conclude by k.2.1
  Let's now prove that R
  We conclude by k.2.2

Conclusion "To practice using the syntax for elements of conjunctions, try to solve this level with fewer uses of `Let's first prove that`, for instance with `We conclude by ⟨⟨k.1, k.2.1⟩, k.2.2⟩`. Announcing the two implications can be avoided entirely by using expressions like `fun s ↦ t` to prove implications like `S ⇒ T`, writing `\\mapsto` to type `↦`."
