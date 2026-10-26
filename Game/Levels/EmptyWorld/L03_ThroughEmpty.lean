import Game.Levels.EmptyWorld.L02_ToEmpty

World "EmptyWorld"
Level 3

Title "Through Empty"

Introduction "In this level, we will explore another weird consequence of the hypothesis that we have a function of type `A → Empty`.

Let `A` and `B` be any types and assume there is a function `f : A → Empty`.

Then it is always possible to define a function `A → B`.

The proof requires a bit of cleverness, but you can ask for a few hints if you get stuck.
"

/-- For any types `A` and `B`, if there is a function `f : A → Empty` then there is also a function `A → B`.-/
Statement {A B : Type} : (A → Empty) → A → B := by
  Hint (hidden := true) "The goal is a function type. Which sentence can be used to define an element?"
  Fix f : A → Empty
  Hint (hidden := true) "The goal is a function type. Which sentence can be used to define an element?"
  Fix a : A
  Hint (hidden := true) "We have assumptions `{f} : A → Empty` and `{a} : A`? What can you construct using this?"
  Hint (hidden := true) "Use `Set e := {f} {a}` or `Set e : Empty := {f} {a}` to add an element of the empty type to the list of assumptions."
  Set e : Empty := f a
  Hint (hidden := true) "An element of `Empty` cannot exist. Which sentence from the first level of this world settles the goal?"
  This is impossible because of e

Conclusion "This level illustrates another strange construction that can be made from an element of type `A → Empty`."
