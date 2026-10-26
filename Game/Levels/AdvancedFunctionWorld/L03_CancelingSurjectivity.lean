import Game.Levels.AdvancedFunctionWorld.L02_Surjectivity

World "AdvancedFunctionWorld"
Level 3

Title "Canceling Surjectivity"

Introduction "Recall that a function `f : A → B` is *surjective* if for every `b : B` there exists some `x : A` so that `f x = b`.

In this level, we will consider a composable pair of functions `f : A → B` and `g : B → C`.

We will show that if the composite `g ∘ f : A → C` is surjective, then the function `g : B → C` is surjective too.
"

/-- For functions `f : A → B` and `g : B → C` if `g ∘ f` is surjective, then so is `g`. -/
TheoremDoc ReintroductionToProofs.Function.Surjective.of_comp as "Surjective.of_comp" in "Function"

namespace ReintroductionToProofs

/-- For functions `f : A → B` and `g : B → C` if `g ∘ f` is surjective, then so is `g`. -/
Statement Function.Surjective.of_comp {A B C : Type} (f : A → B) (g : B → C) (gf_is_surj : ∀ z : C, ∃ x : A, (g ∘ f) x = z) : ∀ c : C, ∃ y : B, g y = c := by
  Hint (hidden := true) "To prove a universally quantified statement, start with `Fix c : C` to introduce an arbitrary element of type `C`."
  Fix c : C
  Hint (hidden := true) "To use the hypothesis `gf_is_surj` at `{c}` and extract the element it provides, write `By gf_is_surj applied to {c} we get a such that ha : (g ∘ f) a = {c}`."
  By gf_is_surj applied to c we get a such that ha : (g ∘ f) a = c
  Hint (hidden := true) "Which element of `B` does `g` send to `{c}`? Announce it with `Let's prove that ?? works`."
  Let's prove that f a works
  Hint (hidden := true) "You can either prove a lemma `Fact lem : (g ∘ f) {a} = ?? from rfl` by replacing the `??` with the definition of the composition function. Or you can try `We rewrite using ← ??` for an appropriate proof of equality using `\\l` to type the left arrow."
  We rewrite using ← ha
  We conclude by rfl

Conclusion "In the next level, we will prove that surjective functions compose."

end ReintroductionToProofs
