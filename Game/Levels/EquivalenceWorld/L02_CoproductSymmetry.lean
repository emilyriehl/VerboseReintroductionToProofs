import Game.Levels.EquivalenceWorld.L01_ProductSymmetry

World "EquivalenceWorld"
Level 2

Title "Coproduct Symmetry"

Introduction "Recall that for any types `A` and `B`, we may form their *coproduct type* `A ⊕ B`.

We proved that there are canonical functions `A ⊕ B → B ⊕ A` and `B ⊕ A → A ⊕ B`.

In this level, we will see that these functions define an equivalence between the type `A ⊕ B` and the type `B ⊕ A`. This gives a more complete account of the symmetry of the coproduct.

To define this equivalence, we need four pieces of data. Start by writing `Let's construct it componentwise` to tell Lean to ask you to supply each piece of data one at a time.
"

open ReintroductionToProofs

/-- For any types `A` and `B`, the coproduct types `A ⊕ B` and `B ⊕ A` are equivalent. -/
Statement {A B : Type} : (A ⊕ B) ≃ (B ⊕ A) := by
  Let's construct it componentwise
  Hint (hidden := true) "Now Lean wants you to define a function `{A} ⊕ {B} → {B} ⊕ {A}`. You can either define this again or find this function in your library."
  Let's use Sum.swap
  Let's use Sum.swap
  Hint "Now Lean wants you to check that the first function followed by the second function yields the identity function at every element `p : {A} ⊕ {B}`. Start with `Fix p : {A} ⊕ {B}`."
  Fix p : A ⊕ B
  Hint (hidden := true) "The functions you have just defined are not definitionally inverses on all elements `{p} : {A} ⊕ {B}`. This is why `We conclude by rfl` fails. Consider the cases for `{p}` first."
  Let's first consider the case where p is inl a
  We conclude by rfl
  Let's next consider the case where p is inr b
  We conclude by rfl
  Fix p : B ⊕ A
  Let's first consider the case where p is inl b
  We conclude by rfl
  Let's next consider the case where p is inr a
  We conclude by rfl

Conclusion "In the next level, we will establish the first of several equivalences involving function types."
