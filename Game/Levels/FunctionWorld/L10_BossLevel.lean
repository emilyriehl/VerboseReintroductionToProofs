import Game.Levels.FunctionWorld.L09_Evaluation

World "FunctionWorld"
Level 10

Title "Boss Level"


Introduction "
We have now reached the Boss Level of Function World, which is considerably more challenging than the Boss Level of Type World. Have fun with this.

We consider an arbitrary pair of types, which we call `V` and `F` &mdash; for *vector space* and *field* respectively &mdash; because the function to be defined below has a connection to linear algebra that is not explained here.

Can you define it?
"

/-- Given a function of type `((((V → F) → F) → F) → F)` there is a canonically defined function of type `(V → F) → F`. -/
Statement {F V : Type} : ((((V → F) → F) → F) → F) → ((V → F) → F) := by
  Fix μ : (((V → F) → F) → F) → F
  Fix φ : V → F
  We apply μ
  Fix α : (V → F) → F
  We apply α
  Let's use φ

Conclusion "Move on to Implication World to revisit these constructions from the prospective of propositions rather than types."
