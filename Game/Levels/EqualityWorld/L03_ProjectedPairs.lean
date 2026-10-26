import Game.Levels.EqualityWorld.L02_PairedProjections

World "EqualityWorld"
Level 3

Title "Projected Pairs"

Introduction "Now consider elements `a : A` and `b : B`.

There is a corresponding pair `⟨a ,b⟩ : A × B` that we can project back to define terms
`⟨a, b⟩.fst : A` and `⟨a , b⟩.snd : B`. How do these relate to the original terms `a` and `b`?

Another *computation rule* for product types tells us `⟨a, b⟩.fst = a` and `⟨a, b⟩.snd = b` by definition, meaning that `We conclude by rfl` can provide proofs."

/-- If `a : A` and `b : B` then the projections of `⟨a, b⟩ : A × B` are definitionally equal to `a : A` and `b : B`, respectively. -/
Statement {A B : Type} (a : A) (b : B) : (⟨a , b⟩ : A × B).fst = a ∧ (⟨a , b⟩ : A × B).snd = b := by
  Hint (hidden := true) "The overall objective here is to prove a conjunction. Which sentence can help break this up into simpler statements? (You will need to restate the first half; `_` is not enough here.)"
  Let's first prove that (⟨a , b⟩ : A × B).fst = a
  We conclude by rfl
  Let's now prove that (⟨a , b⟩ : A × B).snd = b
  We conclude by rfl

Conclusion "Once more, `We conclude by rfl` can also be used to prove propositions of the form `x = y` when `x` and `y` are equal *by definition* (rather than by a more complicated chain of reasoning)."
