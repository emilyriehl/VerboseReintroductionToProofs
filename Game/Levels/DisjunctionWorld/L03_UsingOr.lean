import Game.Levels.DisjunctionWorld.L02_AndImpliesOr

World "DisjunctionWorld"
Level 3

Title "Using Or"

/--
For propositions `P` and `Q`, `Or.symm` is a proof that `P ∨ Q ⇒ Q ∨ P`.
-/
TheoremDoc Or.symm as "symm" in "Or"

Introduction "Given a hypothesis `h : P ∨ Q`, we know that *either* `P` or `Q` is true (or possibly both are true).

But we don't know *which* of `P` or `Q` is true.

If we want to use a hypothesis like this to prove some other proposition `R` is true we need proofs that cover either of the two cases: that is, we need to show that `P` implies `R` (whether or not `Q` is true) and also that `Q` implies `R` (whether or not `P` is true).

If we have an assumption of the form `h : P ∨ Q`, write `Let's consider all cases for h` to ask Lean to consider both cases: the first being that `P` is true and the second being that `Q` is true. Then announce each case in turn, naming the proof it provides: `Let's first consider the case where h is inl p` gives `p : P`, and `Let's next consider the case where h is inr q` gives `q : Q`. (You can choose any names for `p` and `q`, and you may skip the `all cases` line and start directly with `Let's first consider …`.)

This proof strategy should be reminiscent of a definition by cases of a function mapping out of a coproduct type `A ⊕ B`. The same sentences are used for that sort of construction.

Verbose Lean also offers a shorter sentence for the same step, which `help` will suggest: `We proceed using h` splits into the two cases at once, each starting with an implication to be assumed with `Assume p : P` or `Assume q : Q`.

In this level, use the strategy of arguing by cases to prove that or is symmetric, that is that `P ∨ Q` implies `Q ∨ P`."

Statement {P Q : Prop} : P ∨ Q → Q ∨ P := by
  Hint (hidden := true) "What is the outermost logical connective?"
  Assume h : P ∨ Q
  Hint (hidden := true) "After introducing the hypothesis `{h} : {P} ∨ {Q}`, write `Let's consider all cases for {h}`, then announce the first case with `Let's first consider the case where {h} is inl p`."
  Let's consider all cases for h
  Let's first consider the case where h is inl p
  Hint "Note now that Lean provides two goals, both of which are to prove that `{Q} ∨ {P}` is true, under two different hypotheses. Your first task is to prove the theorem in the first case."
  Hint (hidden := true) "Announce which side of `{Q} ∨ {P}` you will prove: `Let's prove that {P}`."
  Let's prove that P
  Hint (hidden := true) "Write `We conclude by {p}`, or `We conclude by hypothesis` to indicate that the goal matches an assumption."
  We conclude by p
  Hint "Note now that you've completed the proof in the first case, Lean expects you to announce the second case: `Let's next consider the case where {h} is inr q`."
  Let's next consider the case where h is inr q
  Let's prove that Q
  Hint (hidden := true) "Write `We conclude by {q}`."
  We conclude by q

Conclusion "This proves the symmetry of disjunction. Try solving it again with `We proceed using h` to compare the two styles."



NewTheorem Or.symm
