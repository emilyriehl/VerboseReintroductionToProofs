namespace ReintroductionToProofs

/-- `α ≃ β` is the type of functions from `α → β` with a two-sided inverse.

(This is the game's own structure, kept deliberately simpler than Mathlib's `Equiv`, which the
Verbose Lean dependency brings into scope; hence the namespace and the high-priority notation.) -/
structure Equiv (α β : Type) where
  toFun : α → β
  invFun : β → α
  left_inv : ∀ a, invFun (toFun a) = a
  right_inv : ∀ b, toFun (invFun b) = b

end ReintroductionToProofs

@[inherit_doc ReintroductionToProofs.Equiv]
infixl:25 (name := gameEquivNotation) (priority := high) " ≃ " => ReintroductionToProofs.Equiv
