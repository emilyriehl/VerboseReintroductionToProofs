import Game.Levels.CoproductWorld.L03_ComponentFunctions

World "CoproductWorld"
Level 4

Title "Universal property"

Introduction "A function `f : A ⊕ B → C` mapping out of a coproduct type may be *broken apart* into component functions of types `A → C` and `B → C`.

Conversely, given an arbitrary pair of functions `g : A → C` and `h : B → C`, one can build a function of type `A ⊕ B → C`.

This function is defined by introducing a variable element `x : A ⊕ B` and then splitting into two cases: the case where `x` is of the form `Sum.inl a` for some `a : A` and the case where `x` is of the form `Sum.inr b` for some `b : B`.

In the first case, the function `g` can be used to define an element `g a : C`, while in the second case the function `h` can be used to define an element `h b : C`.

Given an element `x : A ⊕ B`, write `Let's consider all cases for x` to ask Lean to consider both cases arising from the introduction rules for coproduct types: the first being that `x` is of the form `Sum.inl a` for some `a : A` and the second being that `x` is of the form `Sum.inr b` for some `b : B`.

Each case then has to be *announced* before you work on it. Writing `Let's first consider the case where x is inl a` selects the first case and names the element it comes from `a : A`; later, `Let's next consider the case where x is inr b` selects the second case and names its element `b : B`. (You can choose any names for `a` and `b`, and you may take the cases in either order.) Until a case has been announced, its goal is displayed as &ldquo;You need to announce: …&rdquo;.

If you prefer, you can skip the `all cases` sentence: writing `Let's first consider the case where x is inl a` directly splits into the cases and selects that one.

Both cases will have the same goal type but will have a different context of objects, one of which contains the element `a : A` and the other of which contains the element `b : B`.
"

/-- For types `A`, `B`, and `C`, `Sum.lift : (A → C) → (B → C) → (A ⊕ B → C)` combines a pair of functions of types `A → C` and `B → C` to define a single function of type `A ⊕ B → C`. -/
DefinitionDoc ReintroductionToProofs.Sum.lift as "lift" in "Sum"

def ReintroductionToProofs.Sum.lift {A B C : Type} (g : A → C) (h : B → C) : (A ⊕ B → C) := by
  Fix x : A ⊕ B
  Let's consider all cases for x
  Let's first consider the case where x is inl a
  We apply g
  Let's use a
  Hint (hidden := true) "Announce the second case: `Let's next consider the case where x is inr b`."
  Let's next consider the case where x is inr b
  We apply h
  Let's use b

NewDefinition ReintroductionToProofs.Sum.lift

namespace ReintroductionToProofs

/-- Two functions `g : A → C` and `h : B → C` combine to define a single function of type `A ⊕ B → C`. -/
Statement {A B C : Type} (g : A → C) (h : B → C) : (A ⊕ B → C) := by
  Hint (hidden := true) "Use `Fix` to define a term in a function type."
  Fix x : A ⊕ B
  Hint (hidden := true) "Write `Let's consider all cases for {x}` to consider the possible cases for the variable `{x} : A ⊕ B`, then announce the first one: `Let's first consider the case where {x} is inl a`."
  Let's consider all cases for x
  Let's first consider the case where x is inl a
  We apply g
  Let's use a
  Hint (hidden := true) "Announce the second case: `Let's next consider the case where x is inr b`."
  Let's next consider the case where x is inr b
  We apply h
  Let's use b

Conclusion "We will see later that functions of type `A ⊕ B → C` are uniquely determined by their component functions `(A → C) × (B → C)`."

end ReintroductionToProofs

-- The case-analysis sentences (`Let's consider all cases for x`, `Let's first consider the case where x is inl a`, …) are documented under `Let's`.
