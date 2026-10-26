import Game.Levels.AdvancedFunctionWorld.L03_CancelingSurjectivity

World "AdvancedFunctionWorld"
Level 4

Title "Composing Surjectivity"

Introduction "Recall that a function `f : A → B` is *surjective* if for every `b : B` there exists some `a : A` so that `f a = b`.

Your task in this level is to show that surjective functions compose: if `f : A → B` is surjective and `g : B → C` is surjective, then `g ∘ f : A → C` is surjective.
"

/-- If `f : A → B` and `g : B → C` are both surjective then `g ∘ f : A → C` is also surjective. -/
TheoremDoc ReintroductionToProofs.Function.Surjective.comp as "Surjective.comp" in "Function"

namespace ReintroductionToProofs

/-- If `f : A → B` and `g : B → C` are both surjective then `g ∘ f : A → C` is also surjective. -/
Statement Function.Surjective.comp {A B C : Type} (f : A → B) (g : B → C) (f_is_surj : ∀ b : B, ∃ a : A, f a = b) (g_is_surj : ∀ c : C, ∃ b : B, g b = c) : ∀ c : C, ∃ a : A, (g ∘ f) a = c := by
  Hint (hidden := true) "To prove a universally quantified statement, start with `Fix c : C` to introduce an arbitrary element of type `C`."
  Fix c : C
  Hint (hidden := true) "To use the hypothesis `g_is_surj` at `{c}`, write `By g_is_surj applied to {c} we get b such that hb : g b = {c}`."
  By g_is_surj applied to c we get b such that hb : g b = c
  Hint (hidden := true) "To use the hypothesis `f_is_surj` at `{b}`, write `By f_is_surj applied to {b} we get a such that ha : f a = {b}`."
  By f_is_surj applied to b we get a such that ha : f a = b
  Let's prove that a works
  Hint (hidden := true) "You can either prove a lemma `Fact lem : (g ∘ f) {a} = ?? from rfl` by replacing the `??` with the definition of the composition function. Or you can try `We rewrite using [← ??, ← ??]` using `\\l` to type the left arrow."
  We rewrite using [← hb, ← ha]
  We conclude by rfl

Conclusion "In the next level, we will introduce another property that holds for some, but not all, functions."

end ReintroductionToProofs
