import Game.Levels.NaturalNumbersWorld.L10_SuccessorInjectivity

World "NaturalNumbersWorld"
Level 11
Title "Boss Level"

Introduction "
For the Boss Level of Natural Numbers World you are challenged to prove the fifth Peano axiom, that zero is not the successor of any natural numbers.

For guidance, revisit the proof that `¬ (true = false)` from Boolean World.

Good luck!
"

open Nat
open Nat (zero_add add_zero add_comm)

namespace ReintroductionToProofs


/-- Zero is not the successor of any natural number. -/
Statement : ¬ (∃ n : ℕ, succ n = 0) := by
  Assume hyp : ∃ n : ℕ, succ n = 0
  By hyp we get n such that hn : succ n = 0
  Set P : ℕ → Prop := fun n ↦ match n with | zero => False | succ k => True
  Fact tr : P (succ n) → P 0 by Assume x : P (succ n); We rewrite using ← hn; We conclude by x
  We apply tr
  We conclude by ⟨⟩

Conclusion "There is one remaining level in our game. Move on to Dependent World to encounter type forming operations that take as input families of types, the *dependent types* of dependent type theory."

end ReintroductionToProofs
