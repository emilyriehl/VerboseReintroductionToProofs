import Game.Levels.FunctionWorld

World "ProductWorld"
Level 1

Title "Pairing"

Introduction "The introduction rule for product types tells us that elements of a product type `A × B` are constructed by *pairing* elements of type `A` with elements of type `B`.

Given an element `a : A` and an element `b : B` there is a corresponding element of the product type `A × B` that is denoted by `⟨a, b⟩ : A × B`.

This element should be thought of as an *ordered pair* whose first component is the element `a : A` and whose second element is the element `b : B`.

This can be input directly by writing `Let's use ⟨a, b⟩` using `\\<` and `\\>` to type the angle brackets; note the spacing around the angle brackets and the commas is not important.

Alternatively, you can write `Let's construct the pair`, which allows you to first input the first component and then input the second component.

When the goal is a product type `A × B`, writing `Let's construct the pair` will produce two goals, the first of which has type `A` and the second of which has type `B`.

A note on punctuation: the sentences of this game end without a period, because Lean would read a final `.` as the start of something like `p.1`. If you type one anyway, the game removes it before Lean sees the line.
"

/-- By pairing any element `a : A` with any element `b : B`, there is an element `⟨a, b⟩ : A × B`. -/
Statement {A B : Type} (a : A) (b : B) : A × B := by
  Let's construct the pair
  Hint (hidden := true) "Now Lean asks you to supply an element of type `{A}`. Which sentence applies here?"
  Let's use a
  Hint (hidden := true) "Now Lean asks you to supply an element of type `{B}`. Which sentence applies here?"
  Let's use b

Conclusion "If this is your first time solving this level, go back and solve it another way."

-- Note if you start with `Let's construct the pair` you can then use `Let's use an assumption`. Why does this work?
-- (`Let's construct the pair`, and its general form `Let's construct it componentwise`, are documented under `Let's`.)
