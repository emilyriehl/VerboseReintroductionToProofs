import Game.Levels.NaturalNumbersWorld.L03_Induction

World "NaturalNumbersWorld"
Level 4

Title "Recursion"

Introduction "
Recall the principle of mathematical induction, which applies to an arbitrary family of propositions
`P : ℕ → Prop` and asserts that

`P 0 ⇒ (∀ k : ℕ, P k ⇒ P (succ k)) ⇒ (∀ n : ℕ, P n)`

That is, to prove `∀ n : ℕ, P n` it suffices to verify:
* the base case `P 0` and
* the inductive step `∀ k : ℕ, P k ⇒ P (succ k)`.

The full elimination rule of the type of natural numbers is known in traditional foundations as the
*principle of mathematical recursion*. It applies to an arbitrary family of types `P : ℕ → Type` and defines an element of type

`P 0 → (∀ k : ℕ, P k → P (succ k)) → (∀ n : ℕ, P n)`

The meaning is now slightly different as the arrows should be read as functions rather than implication.

This says that:

* given an element `p_0 : P 0`
* and a function that for all `k : ℕ` defines a function `p_succ k : P k → P (succ k)`

then there is a function that for all `n : ℕ` chooses an element of type `P n`.

This is easiest to understand in the case of a constant type family `fun _ ↦ A : ℕ → Type` defined using a type `A`.

Now recursion defines a function of type `A → (ℕ → A → A) → (ℕ → A)`. This says that:

* given an element `f_0 : A`
* and a function `f_succ : ℕ → A → A`

then we may recursively define a function `ℕ → A`.

We define the function `f : ℕ → A` by specifying that
* `f 0 = f_0` and
* `f (succ k) = f_succ k (f k)`.
Formally speaking, these equalities comprise the *computation rules* for the natural numbers type.

In this level, your objective is to define a particular function `pred : ℕ → ℕ` by recursion so that
* `pred 0 = 0` and
* `pred (succ k) = k`.

In Lean, a function of type `ℕ → A` can be defined recursively using the syntax `fun n ↦ match n with | zero => ? | succ k => ?` where each `?` is replaced by an appropriate element of `A`.

For example, using the data of `f_0 : A` and `f_succ : ℕ → A → A`, the corresponding recursively defined function is

`fun n ↦ match n with | zero => f_0 | succ k => f_succ k (f k)`.

In this game you can give such a function a name with `Set f : ℕ → A := fun n ↦ …`, and then announce it as the witness: `Let's prove that f works`. Alternatively, start with `Let's construct the pair`, `Fix n : ℕ` and `Let's define it by recursion on n`, and announce the two cases as you did for booleans; in the case where `n` is `succ k`, the previously defined value `f k` is introduced with `Fix r : A`.
"

open Nat

/-- There is a function `pred : ℕ → ℕ` that sends `0` to `0` and `succ n` to `n`. -/
Statement : ∃ f : ℕ → ℕ, (f 0 = 0) ∧ (∀ n : ℕ, f (succ n) = n) := by
  Hint (hidden := true) "First define the function `pred : ℕ → ℕ` and give it a name: `Set f : ℕ → ℕ := fun n ↦ match n with | zero => ? | succ k => ?`, replacing the first `?` with the value of `pred zero` and the second `?` with the value of `pred (succ k)`. Lean will accept any function of type `ℕ → ℕ`, but be careful. If you define a *different* function than the predecessor function, the properties you will be asked to prove later will not hold."
  Set f : ℕ → ℕ := fun n ↦ match n with | zero => zero | succ k => k
  Hint (hidden := true) "Now announce that your function is the one: `Let's prove that {f} works`."
  Let's prove that f works
  Hint (hidden := true) "To check that your function was defined correctly, we ask you to calculate its values on `0` and on successors. Hopefully you will be able to solve the goals with `We conclude by rfl`."
  Hint (hidden := true) "The outermost logical connective is a conjunction: `Let's first prove that {f} 0 = 0`."
  Let's first prove that f 0 = 0
  Hint "Here you are asked to show that the value of the function you have just defined at `0` equals `0`."
  We conclude by rfl
  Let's now prove that ∀ n : ℕ, f (succ n) = n
  Hint (hidden := true) "Start with `Fix n : ℕ` to prove the universally quantified statement."
  Fix n : ℕ
  Hint "Here you are asked to show that the value of the function you have just defined at `succ {n}` equals `{n}`."
  We conclude by rfl

Conclusion "The function `Nat.pred : ℕ → ℕ` that you have just defined is now in your library as well as the theorem `Nat.pred_succ n : Nat.pred (succ n) = n`."

/--
The function `Nat.pred : ℕ → ℕ` is defined by recursion to send `0` to `0` and `succ n` to `n`.
-/
DefinitionDoc Nat.pred as "pred" in "ℕ"

NewDefinition Nat.pred

/--
For all natural numbers `n`, `Nat.pred_succ n` proves that `Nat.pred (succ n) = n`.
-/
TheoremDoc Nat.pred_succ as "pred_succ" in "ℕ"

NewTheorem Nat.pred_succ
