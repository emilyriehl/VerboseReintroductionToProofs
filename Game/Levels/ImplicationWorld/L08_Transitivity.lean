import Game.Levels.ImplicationWorld.L07_ProvingAssumedImplication

World "ImplicationWorld"
Level 8

Title "Transitivity"

Introduction "For propositions `P`, `Q`, and `R`, the propositions `(P ⇒ Q) ⇒ R` and `P ⇒ (Q ⇒ R)` are not the same.

The first asserts that `R` is true assuming `P ⇒ Q`. The second asserts that `Q ⇒ R` is true assuming `P`, or equivalently, that `R` is true assuming `P` and also assuming `Q`.

Mathematical statements of this second form `P ⇒ (Q ⇒ R)` are much more common. Thus the shorthand `P ⇒ Q ⇒ R` implicitly refers to `P ⇒ (Q ⇒ R)`, not to the other parenthesization.

More generally, `P ⇒ Q ⇒ R ⇒ S ⇒ T` refers to `P ⇒ (Q ⇒ (R ⇒ (S ⇒ T)))`.

Explicit parentheses must be used to express statements with any other parenthesizations.

Your objective in this level is to prove the transitivity of implication."

/-- If `P ⇒ Q`, then if `Q ⇒ R`, then `P ⇒ R`. -/
Statement {P Q R : Prop} : (P → Q) → (Q → R) → (P → R) := by
  Hint (hidden := true) "As the goal is to prove an implication, the sentence `Assume` can be used to introduce a hypothesis and update the goal. Before writing it, try to figure out which hypothesis will be assumed and what the goal will be, using the discussion about the implicit parenthesization above (`Assume h1 : _` lets Lean fill in the statement)."
  Assume h1 : P → Q
  Hint (hidden := true) "As the goal is to prove an implication, the sentence `Assume` can be used to introduce a hypothesis and update the goal. Before writing it, try to figure out which hypothesis will be assumed and what the goal will be, using the discussion about the implicit parenthesization above (`Assume h1 : _` lets Lean fill in the statement)."
  Assume h2 : Q → R
  Hint (hidden := true) "As the goal is to prove an implication, the sentence `Assume` can be used to introduce a hypothesis and update the goal. Before writing it, try to figure out which hypothesis will be assumed and what the goal will be, using the discussion about the implicit parenthesization above (`Assume h1 : _` lets Lean fill in the statement)."
  Assume p : P
  Hint (hidden := true) "Now you can start to apply some hypotheses to reduce the goal to one of your assumptions. Which sentence can be used here?"
  We apply h2
  We apply h1
  We conclude by p

Conclusion "For compound implications &mdash; statements of the form `P ⇒ Q ⇒ R ⇒ S ⇒ T` &mdash; you can write `Assume (p : P) (q : Q) (r : R) (s : S)` to introduce hypotheses `p : P`, `q : Q`, `r : R`, and `s : S` all at once."
