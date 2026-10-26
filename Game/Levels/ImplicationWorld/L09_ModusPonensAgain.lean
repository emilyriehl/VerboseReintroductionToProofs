import Game.Levels.ImplicationWorld.L08_Transitivity

World "ImplicationWorld"
Level 9

Title "Modus Ponens Again"

Introduction "Modus ponens tells us that under hypotheses `p : P` and `h : P ⇒ Q` then `Q` is true.

The proof is given by `h p : Q`, thought of as the result of applying the proof `h` of the implication `P ⇒ Q` to the proof `p` of `P`.

Can you see why the following theorem is another form of modus ponens?"

/-- If `P` is true, then if `P ⇒ Q` is true, then `Q` is true. -/
Statement {P Q : Prop} : P → (P → Q) → Q := by
  Hint (hidden := true) "When in doubt, start the proof of an implication with `Assume`."
  Assume p : P
  Hint (hidden := true) "When in doubt, start the proof of an implication with `Assume`."
  Assume h : P → Q
  Hint (hidden := true) "You can use `We apply {h}` or conclude with `We conclude by {h} applied to {p}`. Can you understand the meaning of both proofs?"
  We apply h
  We conclude by p

Conclusion "Now we are ready for the Boss Level!"
