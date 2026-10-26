import Game.Levels.EmptyWorld
import Game.Levels.DisjunctionWorld

World "NegationWorld"
Level 1

Title "Ex Falso"

Introduction "The proposition `False` has no elements &mdash; there are no proofs of &ldquo;false.&rdquo;

Consequently, for any other proposition `P`, the implication `False ⇒ P` is true.

The task in this level is to prove this.

The proposition `False` is really just another name for the empty type `Empty`, so the constructions explored in Empty World can be used analogously to prove propositions involving `False`.
"

/-- For any proposition `P`, the implication `False ⇒ P` is true. -/
Statement {P : Prop} : False → P := by
  Hint (hidden := true) "The goal is an implication. Which sentence can be used to start a proof?"
  Assume p : False
  Hint (hidden := true) "Write `This is impossible because of {p}`: there is no proof of `False`, so the goal is settled. (`Let's consider all cases for {p}` works too: there are no cases.)"
  This is impossible because of p

Conclusion "Lean has a built-in name `False.elim : False ⇒ P` for the theorem you have just proven. Thus `We conclude by False.elim` will also solve this level. This theorem has been added to the library."

/-- The proposition `False` has no elements. -/
DefinitionDoc False as "False" in "Prop"

NewDefinition False

TheoremTab "False"

/--
For any proposition `P`, `False.elim : False ⇒ P` proves that `False` implies `P`.
-/
TheoremDoc False.elim as "elim" in "False"

NewTheorem False.elim
