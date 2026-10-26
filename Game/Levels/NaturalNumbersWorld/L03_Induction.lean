import Game.Levels.NaturalNumbersWorld.L02_NormalForms

World "NaturalNumbersWorld"
Level 3

Title "Induction"

Introduction "The *principal of mathematical induction* &mdash; also known as the elimination rule for the type of natural numbers &mdash; is a strategy for proving statements of the form

`∀ n : ℕ, P n`

where `P : ℕ → Prop` is a predicate on the natural numbers &mdash; also known as a family of propositions.

The formal statement of this principle is given by the axiom:

`∀ P : ℕ → Prop, P 0 ⇒ (∀ k : ℕ, P k ⇒ P (succ k)) ⇒ (∀ n : ℕ, P n)`

In plain language it says

&ldquo;for any predicate `P` on the natural numbers, if `P 0` is true, and if `P k` implies `P (succ k)` for all natural numbers `k`, then `∀ n : ℕ, P n` is true.&rdquo;

That is, we can prove `∀ n : ℕ, P n` after verifying two things:

* the *base case*: proving that `P 0` is true
* the *inductive step*: proving that for any `k : ℕ`, `P k` implies `P (succ k)`.

By combining these hypothesis, from the fact that `P 0` is true and `P 0 ⇒ P 1` is true, we can conclude that `P 1` is true. Then from the fact that `P 1 ⇒ P 2` is true, we can conclude that `P 2` is true. Then from the fact that `P 2 ⇒ P 3` is true, we can conclude that `P 3` is true. And so on.

In this level, we will use induction to prove that every natural number is even or odd.

To start a proof by induction, announce the statement you will prove: `Let's prove by induction that ∀ n : ℕ, …`, restating the goal. (When the statement is exactly the current goal, `Let's prove by induction that _` is accepted as a shorthand.) Lean then asks for the base case and, as a separate goal, the inductive step `∀ k : ℕ, P k ⇒ P (k + 1)`.
"

open Nat

/-- Every natural number is even or odd. -/
Statement : ∀ n : ℕ , (∃ m : ℕ, n = 2 * m) ∨ (∃ m : ℕ, n = 2 * m + 1) := by
  Hint "To start a proof by induction, write `Let's prove by induction that ∀ n : ℕ, (∃ m : ℕ, n = 2 * m) ∨ (∃ m : ℕ, n = 2 * m + 1)` (or the shorthand `Let's prove by induction that _`). This will split the goal into two cases: proving the base case and the inductive step."
  Let's prove by induction that ∀ n : ℕ, (∃ m : ℕ, n = 2 * m) ∨ (∃ m : ℕ, n = 2 * m + 1)
  Hint "You are first asked to prove the base case assuming the natural number `n` from the original statement is `0`. Thus your goal is to prove `(∃ m : ℕ, 0 = 2 * m) ∨ (∃ m : ℕ, 0 = 2 * m + 1)`. Announce the side of the disjunction you'd like to prove by restating it: `Let's prove that ∃ m : ℕ, 0 = 2 * m`."
  Let's prove that ∃ m : ℕ, 0 = 2 * m
  Hint (hidden := true) "To prove the existential quantifier, write `Let's prove that ?? works` with an explicit numeral in the place of `??` to supply a well-chosen value of `m`."
  Let's prove that 0 works
  Hint (hidden := true) "Recall arithmetical equations involving numerals can be proven with `We conclude by rfl`."
  We conclude by rfl
  Hint "Now that you have completed the base case, the next goal is to prove the inductive step `∀ k : ℕ, P k ⇒ P (k + 1)`. Write `Fix k : ℕ` to consider an arbitrary natural number, and then assume the inductive hypothesis that the predicate is true for `k`: `Assume hk : (∃ m : ℕ, k = 2 * m) ∨ (∃ m : ℕ, k = 2 * m + 1)`."
  Fix k : ℕ
  Assume hk : (∃ m : ℕ, k = 2 * m) ∨ (∃ m : ℕ, k = 2 * m + 1)
  Hint "Your goal is to prove that the analogous result holds for `{k} + 1`, aka, the successor of `{k}`. Write `We proceed using {hk}` to split into cases depending on whether or not `{k}` is even or odd."
  We proceed using hk
  Hint (hidden := true) "Write `Assume even : ∃ m : ℕ, {k} = 2 * m` to name the hypothesis of this case."
  Assume even : ∃ m : ℕ, k = 2 * m
  Hint (hidden := true) "If `{k}` is even then `{k} + 1` is odd: announce the side of the disjunction you'd like to prove with `Let's prove that ∃ m : ℕ, {k} + 1 = 2 * m + 1`."
  Let's prove that ∃ m : ℕ, k + 1 = 2 * m + 1
  Hint (hidden := true) "Write `By {even} we get d such that hd : {k} = 2 * d` to decompose the hypothesis."
  By even we get d such that hd : k = 2 * d
  Hint (hidden := true) "Write `Let's prove that ?? works` with a well-chosen element in place of the `??`."
  Let's prove that d works
  Hint (hidden := true) "This equality does not hold by definition, so `We conclude by rfl` fails. But your context has a new hypothesis that can help: `We rewrite using {hd}`."
  We rewrite using hd
  We conclude by rfl
  Hint (hidden := true) "Write `Assume odd : ∃ m : ℕ, {k} = 2 * m + 1` to name the hypothesis of this case."
  Assume odd : ∃ m : ℕ, k = 2 * m + 1
  Hint (hidden := true) "Announce the side of the disjunction you'd like to prove with `Let's prove that …`."
  Let's prove that ∃ m : ℕ, k + 1 = 2 * m
  Hint (hidden := true) "Write `By {odd} we get d such that hd : {k} = 2 * d + 1` to decompose the hypothesis."
  By odd we get d such that hd : k = 2 * d + 1
  Hint (hidden := true) "Write `Let's prove that ?? works` with a well-chosen element in place of the `??`."
  Let's prove that d + 1 works
  Hint (hidden := true) "This equality does not hold by definition, so `We conclude by rfl` fails. But your context has a new hypothesis that can help."
  We rewrite using hd
  We conclude by rfl

Conclusion "It is a bit surprising that the last equation `2 * d + 1 + 1 = 2 * (d + 1)` holds by `rfl`. This has to do with the way that addition and multiplication are defined in Lean. We will explore the definition of addition in a future level."

-- (the words of `Let's prove by induction that …` are declared game-wide in TypeWorld level 1)
