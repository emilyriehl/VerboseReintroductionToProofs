import Game.Levels.NaturalNumbersWorld.L08_AddingSuccessors

World "NaturalNumbersWorld"
Level 9

Title "Commuting Addition"

Introduction "
Using the theorems we have proven so far, we can now prove a serious theorem about the natural numbers, namely the commutativity of addition.

That is, we will show that for all natural numbers `m` and `n`, `m + n = n + m`.

This can be proven by induction on either variable. For an extra challenge, try proving this both ways.

Good luck!
"

open Nat
open Nat (zero_add add_zero)

/-- For all natural numbers `m n`, `m + n = n + m`. -/
Statement : ∀ m n : ℕ, m + n = n + m := by
  Fix (m : ℕ) (n : ℕ)
  Let's prove by induction that ∀ n : ℕ, m + n = n + m
  We rewrite using Nat.zero_add
  We conclude by rfl
  Fix k : ℕ
  Assume hk : m + k = k + m
  We rewrite using add_succ
  We rewrite using hk
  We rewrite using succ_add
  We conclude by rfl

Conclusion "This proves the theorem `Nat.add_comm : ∀ m n : ℕ, m + n = n + m`, which is now in your library."

/--
For `m n : Nat`, `Nat.add_comm m n` is the proof that `m + n = n + m`.
-/
TheoremDoc Nat.add_comm as "add_comm" in "ℕ"

NewTheorem Nat.add_comm

DisabledTheorem Nat.add_comm
DisabledTactic «compute»
