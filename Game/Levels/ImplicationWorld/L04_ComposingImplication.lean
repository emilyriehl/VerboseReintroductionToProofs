import Game.Levels.ImplicationWorld.L03_ApplyingImplication

World "ImplicationWorld"
Level 4

Title "Composing Implication"

Introduction "Now we are in the setting of three proposition variables `P`, `Q`, and `R` with several hypotheses.

The first assumption provides a proof `p` that the proposition `P` is true.

The second provides a proof `h1` that the implication `P ⇒ Q` is true.

The final hypothesis provides a proof `h2` that `Q ⇒ R` is true. Our goal is to conclude that `R` is true.

This can be proven either backwards &mdash; with `We apply` &mdash; or forwards &mdash; by directly constructing proofs out of our hypotheses.

But it is also possible to work forwards with the sentence `Claim`, which is now in your library.

`Claim` can be used to add new hypotheses provided you can supply a proof.

For example, given assumptions `p : P` and `h1 : P ⇒ Q`, write `Claim q : Q from h1 applied to p` to add a proof `q : Q` of `Q`.

If you like, you can use `Claim` again to add a proof of `R` to the assumptions, by writing `Claim r : R from h2 applied to q`.

`Claim` often makes proofs longer but it also makes them easier to read and easier to find.

Practice using both forwards and backwards reasoning to solve this level.
"

/-- If `P` is true, `P ⇒ Q` is true, and `Q ⇒ R` is true, then `R` is true. -/
Statement {P Q R : Prop} (p : P) (h1 : P → Q) (h2 : Q → R) : R := by
  Hint (hidden := true) "In the presence of a hypothesis `h : S ⇒ T`, the sentence `We apply h` reduces the problem of proving `T` to the problem of proving `S`. Can this be used here?"
  We apply h2
  Hint (hidden := true) "In the presence of a hypothesis `h : S ⇒ T`, the sentence `We apply h` reduces the problem of proving `T` to the problem of proving `S`. Can this be used here?"
  We apply h1
  Hint (hidden := true) "If the goal is to prove `S` and we have a hypothesis `s : S`, the sentence `We conclude by s` supplies the required proof."
  We conclude by p

Conclusion "We've seen that an implication `h : P ⇒ Q` can be applied in the presense of a proof `p : P` to provide a proof of the proposition `Q`. This explains how implications are *used* in proofs of other statements. In the next level, we will see how implications can be *proven*."

/-- `Claim h : P from e` adds a new hypothesis `h : P` to the context, proved by `e` (for example `Claim q : Q from h1 applied to p`). You may leave out the name, `Claim P from e`, and Lean picks one. Other forms: `Claim h : P since …` (prove it from stated facts), `Claim h : P by computation`, and `Claim h : P by` followed by an indented proof on the next lines (editor mode). -/
TacticDoc «Claim»

NewTactic «Claim»
