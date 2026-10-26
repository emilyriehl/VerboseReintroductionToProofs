import Game.Levels.FunctionWorld

World "ImplicationWorld"
Level 1

Title "By Assumption"

Introduction "
We warm up by revisiting our first mathematical theorem, proven already in Type World.

This theorem concerns an arbitrary proposition `P` which can be any well-formed mathematical statement.

The hypothesis `p : P`  can be thought of as providing a *proof* `p` that the proposition `P` is true. Our objective is to conclude that `P` is true, given this hypothesis.

This is true by assumption, and you can write `We conclude by hypothesis` to tell Lean this.

But it is a bit more precise to tell Lean this is true by the assumption `p`, which can be done by writing `We conclude by p`.

If it is helpful to review these sentences, you can read more about them under `We` in the library on the upper right."

/-- If the proposition `P` is true, then `P` is true.-/
Statement {P : Prop} (p : P) : P := by
  Hint (hidden := true) "To use the hypothesis `{p}` to reach this conclusion write `We conclude by {p}`."
  We conclude by p

Conclusion "You can click on `Retry` to attempt a different proof."
