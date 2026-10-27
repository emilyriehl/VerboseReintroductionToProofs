import Game.Levels.NegationWorld

World "ClassicalWorld"
Level 1

Title "By Contradiction"

Introduction "Let `P` be a proposition.

We have learned that there is a default strategy to prove `¬ P`, i.e., that `P` implies `False`.

The strategy is to start by assuming we have a proof `p : P`, in other words, assuming that `P` is true.

Then the goal is to derive an element of `False`, also known as a *contradiction*.

This proof strategy is fully compatible with constructive mathematics.

There is a related, but distinct, strategy in classical logic that can be used to prove a proposition `P` assuming called &ldquo;proof by contradiction&rdquo;. Here one assumes we have a proof `np : ¬ P`, in other words, assuming that `P` is false.

The goal is again to derive an element of `False`, also known as a contradiction.

Such a proof &mdash; assuming `np : ¬ P` and then deriving an element of `False` &mdash; constructs an element of `¬ ¬ P`.

In classical logic, there is an implication `¬ ¬ P ⇒ P`, which is why &ldquo;proof by contradiction&rdquo; can be used to ultimately prove that `P` is true.

In this game, a proof by contradiction of a goal `P` is started with the sentence `Assume for contradiction np : ¬ P`: it adds `np : ¬ P` to the context and changes the goal to `False`. The classical principle itself is available as `Classical.byContradiction : ¬ ¬ P ⇒ P`, so `We conclude by Classical.byContradiction` also solves this level."

section
open Classical

/-- In classical logic, for any proposition `P`, `¬ ¬ P` implies `P`. -/
Statement {P : Prop} : ¬ ¬ P → P := by
  Hint (hidden := true) "Start as for any implication: `Assume h : ¬ ¬ {P}`."
  Assume h : ¬ ¬ P
  Hint "Now argue by contradiction: `Assume for contradiction np : ¬ {P}`."
  Assume for contradiction np : ¬ P
  Hint (hidden := true) "The goal is `False`. Write `We conclude by {h} applied to {np}`."
  We conclude by h applied to np

end

Conclusion "Lean has a built-in name `Classical.byContradiction : ¬ ¬ P ⇒ P` for this implication,
which is also called *double negation elimination*. Verbose Lean's `Assume for contradiction` applies it for you; the sentence refuses to argue by contradiction when the goal is itself a negation, because then a direct `Assume` does the job."

TheoremTab "Classical"

/--
For any proposition `P`, `Classical.byContradiction : ¬ ¬ P ⇒ P` proves that if `P` is not false, then `P` is true.
-/
TheoremDoc Classical.byContradiction as "byContradiction" in "Classical"

NewTheorem Classical.byContradiction
