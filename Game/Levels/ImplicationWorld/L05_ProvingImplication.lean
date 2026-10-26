import Game.Levels.ImplicationWorld.L04_ComposingImplication

World "ImplicationWorld"
Level 5

Title "Proving Implication"

Introduction "To prove an implication `P ⇒ Q` one needs to give a construction of a proof of `Q` from a hypothesized proof of `P`.

In particular, to prove that `P ⇒ Q` it suffices to assume that we have a proof `p : P` &mdash; even if `P` is false and such a proof does not exist &mdash; in which case the new goal is to find a proof of `Q`.

When the goal has the form `P ⇒ Q`, write `Assume p : P` to introduce an assumption `p : P` and update the goal to proving `Q` &mdash; asking for a proof that `Q` is true under the assumption that `P` is true. You choose the name `p`; after the colon comes the hypothesis of the implication (or `_`, and Lean fills it in). It is also possible to write `Assume that P`, in which case Lean chooses a name for the proof of `P`.

`Assume` is the counterpart, for implications, of the sentence `Fix` for function types: `Fix` introduces an arbitrary *element*, `Assume` introduces a *hypothesis*.

In this level, we will see that for any proposition `P`, `P ⇒ P` is true. Indeed, this is the case even if `P` itself is false!"

/-- For any proposition `P`, `P` implies `P` is true. -/
Statement {P : Prop} : P → P := by
  Hint (hidden := true) "When the goal has the form `{P} ⇒ {P}`, write `Assume p : {P}` to introduce an assumption `p : {P}` and update the goal to `{P}`."
  Assume p : P
  Hint (hidden := true) "Now the goal is to prove `{P}` assuming `{p} : {P}`. Which sentence can be used to supply this proof?"
  We conclude by p

Conclusion "Let us now explore other implications that are provable with this strategy."

/-- When the goal is an implication `P ⇒ Q` (or a negation `¬ P`, which is `P ⇒ False`):

* `Assume h : P` introduces the hypothesis as an assumption named `h` and makes `Q` the goal. The statement after the colon must be the hypothesis of the implication; you may write `_` for it (`Assume h : _`) and Lean fills it in.
* `Assume that P` does the same and names the assumption for you (here `hP`); `Assume that _` also works.
* Several at once: `Assume (h1 : P) (h2 : Q)`.
* `Assume for contradiction h : ¬ Q` starts a proof by contradiction when the goal is `Q` (Classical World).

Typing symbols: `\\=>` gives `⇒`, `\\to` gives `→` (both are accepted), `\\not` gives `¬`. -/
TacticDoc «Assume»

NewTactic «Assume»
