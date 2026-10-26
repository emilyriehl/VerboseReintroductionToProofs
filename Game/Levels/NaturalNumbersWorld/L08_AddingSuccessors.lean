import Game.Levels.NaturalNumbersWorld.L07_AddingZero

World "NaturalNumbersWorld"
Level 8

Title "Adding Successors"

Introduction "
The addition function `+ : ℕ → ℕ → ℕ` is defined by the equations

* `add_zero n : n + 0 = n` and
* `add_succ m n : m + succ n = succ (m + n)`.

It is of course also true that `succ m + n = succ (m + n)` for all natural numbers `m` and `n`, but this equation does not hold by definition.

Instead you have to prove it by induction!

Good luck.
"

open Nat
open Nat (zero_add add_zero)

/-- For all natural numbers `m n`, `m + succ n = succ (m + n)` and `succ m + n = succ (m + n)`. -/
Statement : ∀ m n : ℕ, m + succ n = succ (m + n) ∧ succ m + n = succ (m + n)  := by
  Fix (m : ℕ) (n : ℕ)
  Let's first prove that m + succ n = succ (m + n)
  We conclude by rfl
  Let's now prove that succ m + n = succ (m + n)
  Hint "It is time to appeal to induction, but should induct in the variable `{m}` or `{n}`? If we had already proven that addition is commutative, the choice would not matter, but given what we have shown so far, you will find that to make progress you need to induct on the same variable we used to define the addition function."
  Let's prove by induction that ∀ n : ℕ, succ m + n = succ (m + n)
  We conclude by rfl
  Fix k : ℕ
  Assume hk : succ m + k = succ (m + k)
  We rewrite using add_succ
  We rewrite using hk
  We rewrite using ← add_succ
  We conclude by rfl

Conclusion "The second half of this proves the theorem `Nat.succ_add : ∀ m n : ℕ, succ m + n = succ (m + n)`, which is now in your library."

/--
For `m n : Nat`, `Nat.succ_add m n` is the proof that `(succ m) + n = succ (m + n)`.
-/
TheoremDoc Nat.succ_add as "succ_add" in "ℕ"

NewTheorem Nat.succ_add

DisabledTheorem Nat.succ_add
DisabledTactic «compute»
