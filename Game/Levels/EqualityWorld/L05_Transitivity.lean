import Game.Levels.EqualityWorld.L04_Symmetry

World "EqualityWorld"
Level 5

Title "Transitivity"

Introduction "We've seen that equality is *reflexive*, meaning that `x = x` for any element `x : A`.

We've also proven that equality is *symmetric*: if `x = y` then `y = x`.

In this level, we will prove that equality is *transitive*: if `x = y` and `y = z`, then `x = z`.
"

/-- Equality is transitive: if `x = y` and `y = z` then `x = z`. -/
Statement {A : Type} {x y z : A} (p : x = y) (q : y = z) : x = z  := by
  We rewrite using [← q, ← p]
  We conclude by rfl

Conclusion "Try solving the goal by rewriting in both directions. You can also perform several rewrites at once, separating the equalities by commas inside square brackets: `We rewrite using [p, q]`. Why does `We rewrite using [p, q]` work but `We rewrite using [q, p]` not? Why does `We rewrite using [← q, ← p]` or `We rewrite using [← q, p]` work but `We rewrite using [← p, ← q]` not?"

/-- Given elements `x y z : A` and proofs `p : x = y` and `q : y = z`, `Eq.trans p q` or `p.trans q` are two names for the corresponding proof `x = z`. -/
TheoremDoc Eq.trans as "trans" in "Eq"

NewTheorem Eq.trans

DisabledTheorem Eq.trans
