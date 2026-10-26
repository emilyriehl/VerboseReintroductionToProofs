import Game.Levels.ClassicalWorld.L02_Contrapositive

World "ClassicalWorld"
Level 3

Title "Excluded Middle"

Introduction "The *law of excluded middle* asserts that for any proposition `P`, either `P` is true or `P` is false.

In other words, for any proposition `P`, `P ∨ ¬ P` is always true.

Lean has a built-in name `Classical.em P : P ∨ ¬ P` for *the law of excluded middle* at the proposition `P`. To bring it into your context write `Fact lemP : P ∨ ¬ P from Classical.em P`, and then consider its two cases as for any disjunction. Verbose Lean also has a one-sentence version of this, which `help` will suggest: `We discuss depending on whether P or ¬ P` splits into the two cases directly, each starting with an assumption to introduce.

Note that in contrast to `Classical.byContradiction : ¬ ¬ P ⇒ P`, the proposition `P` is an *explicit argument* of `Classical.em`.

This is because when you are applying proof by contradiction, it is usually clear from context which proposition `P` is involved, whereas when you are appealing to the law of excluded middle, this is often not so clear.

See if you can use the law of excluded middle to prove that for any propositions `P` and `Q` one
of the following four conjunctions holds.
"

section
open Classical

/-- In classical logic, for any propositions `P` and `Q`, `P ∧ Q` is true or `P ∧ ¬ Q` is true or `¬ P ∧ Q` is true or `¬ P and ¬ Q` is true. -/
Statement {P Q : Prop} : (P ∧ Q) ∨ (P ∧ ¬ Q) ∨ (¬ P ∧ Q) ∨ (¬ P ∧ ¬ Q) := by
  Hint (hidden := true) "To use the law of excluded middle in your proof, write `Fact lemP : P ∨ ¬ P from Classical.em P` to add an assumption that `P ∨ ¬ P` is true."
  Fact lemP : P ∨ ¬ P from Classical.em P
  Hint (hidden := true) "Do the same for `Q`: `Fact lemQ : Q ∨ ¬ Q from Classical.em Q`."
  Fact lemQ : Q ∨ ¬ Q from Classical.em Q
  Hint (hidden := true) "What can you do with these assumptions?"
  Let's first consider the case where lemP is inl p
  Let's first consider the case where lemQ is inl q
  We conclude by Or.inl ⟨p, q⟩
  Let's next consider the case where lemQ is inr nq
  We conclude by Or.inr (Or.inl ⟨p, nq⟩)
  Let's next consider the case where lemP is inr np
  Let's first consider the case where lemQ is inl q
  We conclude by Or.inr (Or.inr (Or.inl ⟨np, q⟩))
  Let's next consider the case where lemQ is inr nq
  We conclude by Or.inr (Or.inr (Or.inr ⟨np, nq⟩))

end

Conclusion "The classical tautology `Classical.em P : P ∨ ¬ P` has been added to your library of theorems and can be referred to by the name `Classical.em _`, with the desired proposition replacing the `_`."

/--
For any proposition `P`, `Classical.em P : P ∨ ¬ P ` proves that `P` or `¬ P` is true.
-/
TheoremDoc Classical.em as "em" in "Classical"

NewTheorem Classical.em
