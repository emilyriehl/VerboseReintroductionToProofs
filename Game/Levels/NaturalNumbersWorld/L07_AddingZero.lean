import Game.Levels.NaturalNumbersWorld.L06_DefiningAddition

World "NaturalNumbersWorld"
Level 7

Title "Adding Zero"

Introduction "
The addition function `+ : ℕ → ℕ → ℕ` is defined by the equations

* `add_zero n : n + 0 = n` and
* `add_succ m n : m + succ n = succ (m + n)`.

It is of course also true that `0 + n = n` for all natural numbers `n`, but this equation does not hold by definition.

Instead you have to prove it by induction! (`We compute` is switched off in this level and the next ones: it would do the work for you.)

Good luck.
"

open Nat

/-- For all natural numbers `n`, `n + 0 = n` and `0 + n = n`. -/
Statement : ∀ n : ℕ, (n + 0 = n) ∧ (0 + n = n) := by
  Fix n : ℕ
  Hint (hidden := true) "The statement is a conjunction so use `Let's first prove that {n} + 0 = {n}` to break into subgoals."
  Let's first prove that n + 0 = n
  We conclude by rfl
  Let's now prove that 0 + n = n
  Hint (hidden := true) "To use the principle of mathematical induction, write `Let's prove by induction that ∀ n : ℕ, 0 + n = n`. Lean notices that your goal is the case of this statement for `{n}`."
  Let's prove by induction that ∀ n : ℕ, 0 + n = n
  We conclude by rfl
  Fix k : ℕ
  Assume hk : 0 + k = k
  Hint "It would be nice if we could use the hypothesis `{hk}` to replace the `0 + {k}` in the goal with the element `{k}`, but the parentheses in the left-hand side of the goal equation are not a match for this. Lean thinks that the left hand side is of the form `0 + succ {k}`. Do we have any theorems that can be used to rewrite this into something else?"
  Hint (hidden := true) "To apply the theorem `Nat.add_succ` write `We rewrite using add_succ`."
  We rewrite using add_succ
  Hint (hidden := true) "Now you can rewrite along the hypothesis `{hk}`."
  We rewrite using hk
  We conclude by rfl


Conclusion "The second half of this proves the theorem `Nat.zero_add : ∀ n : ℕ, 0 + n = n`, which is now in your library."

/--
For `n : ℕ`, `Nat.zero_add n` is the proof that `0 + n = n`.
-/
TheoremDoc Nat.zero_add as "zero_add" in "ℕ"

NewTheorem Nat.zero_add

DisabledTheorem Nat.zero_add
DisabledTactic «compute»
