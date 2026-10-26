import Game.Levels.EqualityWorld.L03_ProjectedPairs

World "EqualityWorld"
Level 4

Title "Symmetry"

Introduction "We've already seen that equality is *reflexive*, meaning that `x = x` for any element `x : A`.

In this level, we will prove that equality is also symmetric: if `x = y` then `y = x`.

To prove the implication `x = y → y = x` we may assume that we have a proof `p : x = y`. This allows us to appeal to the elimination rule of equality types to prove our goal that `y = x` also holds.

To do this, we will make use of the sentence `We rewrite using p`, which is the primary way we will use a hypothesis of the form `p : x = y`.

If we have a hypothesis `p : x = y`, then `We rewrite using p` will replace the element `x` in the goal by `y`.

In the case here, the goal is to show that `y = x`, so rewriting along `p` will change the goal to `y = y`. Rewriting never finishes a proof by itself: what remains is an equation between identical sides, which you close with `We conclude by rfl`.

This sentence can be used in two directions: `We rewrite using ← p` &mdash; using `\\l` to type `←` &mdash; will replace `y` in the goal by `x`. Thus writing `We rewrite using ← p` instead of `We rewrite using p` will change the goal to `x = x`.

Try solving this level using both directions of rewriting.
"

/-- Equality is symmetric: if `x = y` then `y = x`. -/
Statement {A : Type} {x y : A} (p : x = y) : y = x  := by
  We rewrite using p
  We conclude by rfl

Conclusion "We will now explore other applications of `We rewrite using`. (`We rewrite using h at h'` rewrites inside a hypothesis `h'` instead of the goal.)"

-- Temporary, while later worlds are still being ported: the original's `rw`.
NewHiddenTactic rw

/-- Given elements `x y : A` and a proof `p : x = y`, `Eq.symm p` or `p.symm` are two names for the corresponding proof `y = x`. -/
TheoremDoc Eq.symm as "symm" in "Eq"

NewTheorem Eq.symm

DisabledTheorem Eq.symm
