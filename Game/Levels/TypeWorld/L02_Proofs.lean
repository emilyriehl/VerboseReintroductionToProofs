import Game.Levels.TypeWorld.L01_Elements

World "TypeWorld"
Level 2

Title "Proofs"

Introduction "In this level, we consider a proposition `P` in place of a type `A`.

When a proposition `P` has an element `p : P` we think of `p` as a *proof* that the proposition `P` is true.

The context for this level collectively asserts that `P` is a proposition and `p` is a proof of `P`. In particular, our assumptions imply that the proposition `P` is true.

As we will see, it is useful to have an explicit name `p` for the proof that `P` is true. When we reference the truth of the proposition `P` to prove other propositions, we will do so by referring to the element `p`.

Our goal, which is displayed to the right of the vertical line, is to prove the proposition `P`.

Claim that `P` is true because we have assumed that `P` is true. The sentence `Let's use an assumption` from the previous level works here too. When the goal is a proposition, there is a second sentence for the same step that reads more like a proof on paper: `We conclude by hypothesis`.
"

/-- Under the hypothesis that we have a proposition `P` and a proof `p : P`, we may conclude that `P` is true. -/
Statement {P : Prop} (p : P) : P := by
  Hint (hidden := true) "Write `We conclude by hypothesis` (or `Let's use an assumption`) to tell Lean that `P` is true by assumption."
  We conclude by hypothesis

Conclusion "In the next level, we will learn to be more precise about which assumption is being used."

/-- Sentences starting with `We` finish or transform the goal.

Finishing:
* `We conclude by hypothesis` closes the goal with an assumption, without naming it.
* `We conclude by h` closes the goal with the hypothesis or proof term `h`; also `We conclude by h applied to x`, `We conclude by h applied to x and y`, and `We conclude by rfl` when both sides of an equation are equal by definition.

Recording a fact (introduced in Implication World):
* `Claim h : P from e` adds `h : P` to your assumptions, proved by `e`; also `Claim P from e` (Lean names the fact), `Claim h : P by …`, and `Claim h : P since h₁ and h₂`.

Transforming the goal (introduced in later worlds):
* `We apply h` when `h : P ⇒ Q` and the goal is `Q`: the goal becomes `P`.
* `We rewrite using h` when `h : a = b` replaces `a` by `b` in the goal (backwards: `We rewrite using ← h`; in a hypothesis: `… at h'`).
* `We compute` normalises arithmetic on both sides of an equation (Natural Numbers World).
* `We proceed using h` when `h : P ∨ Q` or `h : A ⊕ B`: one goal per case.
* `We discuss depending on whether P or ¬ P`: case split on a proposition. -/
TacticDoc «We»

NewTactic «We»
