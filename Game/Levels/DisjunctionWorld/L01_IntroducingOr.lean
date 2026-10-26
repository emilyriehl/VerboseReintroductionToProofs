import Game.Levels.ConjunctionWorld
import Game.Levels.CoproductWorld

World "DisjunctionWorld"
Level 1

Title "Introducing Or"

Introduction "To prove a disjunction `P ∨ Q` it suffices to supply a proof of either `P` or of `Q`.

Thus under the hypothesis that `P` and `Q` are both true, there are two ways to prove `P ∨ Q`: one using `p : P` and one using `q : Q`.

Note `We conclude by p` or `We conclude by q` won't work as these are proofs of different propositions, namely the proposition `P` or the proposition `Q`.

To give a proof you have two choices: to reduce to the case of proving the left proposition or to reduce to the case of proving the right proposition.

Write `Let's prove that P` to tell Lean you'd like to prove the left proposition or `Let's prove that Q` to tell Lean you'd like to prove the right proposition: you announce the side by *stating* it.
"

/-- There are two ways to prove `P ∨ Q` from the given hypotheses. Can you find them both?-/
Statement {P Q : Prop} (p : P) (q : Q) : P ∨ Q := by
  Branch
    Let's prove that P
    Hint (hidden := true) "What is the goal now?"
    We conclude by p
  Branch
    Let's prove that Q
    Hint (hidden := true) "What is the goal now?"
    We conclude by q
  We conclude by Or.inl p

Conclusion "If this is your first time solving this level, delete your code and prove the same theorem another way. Alternatively, you can prove `P ∨ Q` by applying either of the implications `Or.inl : P ⇒ P ∨ Q` and `Or.inr : Q ⇒ P ∨ Q` that are now in the library: `We apply Or.inl`, or in one line `We conclude by Or.inl p`."


/-- For propositions `P` and `Q`, `Or.inl` is a proof that `P ⇒ (P ∨ Q)`. -/
DefinitionDoc Or.inl as "inl" in "Or"

/-- For propositions `P` and `Q`, `Or.inr` is a proof that `Q ⇒ (P ∨ Q)`. -/
DefinitionDoc Or.inr as "inr" in "Or"

NewDefinition Or.inl Or.inr
