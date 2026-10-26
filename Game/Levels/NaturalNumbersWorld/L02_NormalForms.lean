import Game.Levels.NaturalNumbersWorld.L01_Numerals

World "NaturalNumbersWorld"
Level 2

Title "Normal Forms"

Introduction "
More complicated arithmetic equations involving numerals also hold by definition: for example `1 + 5 = 2 * 3`

This is because these elements on both the left-hand and right-hand sides reduce to a common *normal form*, an explicit numeral of the form `succ (succ (succ (succ (succ (succ 0))))`.

So far such equalities were proven with `We conclude by rfl`. This level introduces a new sentence, `We compute`, which asks Lean to carry out these reductions: it normalises the arithmetic expressions on both sides of an equation and checks that the results agree. It even handles all the equations of a conjunction at once.

"

open Nat

/-- Arithmetic equations involving explicit numerals such as `12 + 23 = 5 * (4 + 3)` hold by `rfl`. -/
Statement : (2 + 2 = 4) ∧ (1 + 5 = 2 * 3) ∧ (12 + 23 = 5 * (4 + 3)) ∧ (2 * 5 = 5 * 2) ∧ ((3 + 1) + 2 = 2 + (1 + 3)) := by
  Hint (hidden := true) "Each equation holds by definition, so `We conclude by ⟨rfl, rfl, rfl, rfl, rfl⟩` works. But try the new sentence `We compute`."
  We compute

Conclusion "`We compute` solves this level in one line. Be warned that it is powerful: it also proves equations such as `n + 0 = n` and `0 + n = n` for a variable `n`. In the levels where you are asked to prove such facts yourself, by induction, `We compute` is switched off."

/-- `We compute` asks Lean to compute both sides of an equation and compare the results. It normalises arithmetic expressions (`2 + 2` becomes `4`, `2 * (m + 1)` becomes `2 * m + 2`), so it proves equations between numerals and equations that hold by rearranging sums and products; on a conjunction of such equations it handles every part. `We compute at h` does the same inside a hypothesis `h`. It does not use your assumptions: an equation that depends on a hypothesis `h : k = 2 * m` needs `We rewrite using h` first. -/
TacticDoc «compute»

NewTactic «compute»
