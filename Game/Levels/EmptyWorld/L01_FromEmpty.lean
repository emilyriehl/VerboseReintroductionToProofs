import Game.Levels.CoproductWorld

World "EmptyWorld"
Level 1

Title "From Empty"

Introduction "The type `Empty` has no elements &mdash; or, more precisely, the type `Empty` has no introduction rules.

Consequently, for any other type `A`, there is always a function `Empty → A`.

The task in this level is to define it.
"

/-- For any type `A`, there is a function `Empty → A` encoding the elimination rule of the empty type. -/
Statement {A : Type} : Empty → A := by
  Hint (hidden := true) "The goal is a function type. Which sentence can be used to define an element?"
  Fix p : Empty
  Hint "Write `This is impossible because of {p}`: an element of the empty type cannot exist, so whatever the goal is, it is settled. (Alternatively, `Let's consider all cases for {p}` asks Lean to consider all possible cases for an element of the empty type; as there are none, this completes the construction too.)"
  This is impossible because of p

Conclusion "Lean has a built-in name `Empty.elim : Empty → A` for the function you have just defined. Thus `Let's use Empty.elim` will also solve this level. This function has been added to the library."


/-- The empty type `Empty` has no introduction rules. It is an inductive type, meaning that it is in some sense *freely generated* by the elements provided by its introduction rules. In this case, this means that the elimination rule provides a canonical function `Empty.elim : Empty → A` valued in any type `A`. -/
DefinitionDoc Empty as "Empty" in "Type"

/--
For any type `A`, there is a function `Empty.elim : Empty → A` expressing the elimination rule of the empty type.
-/
DefinitionDoc Empty.elim as "Empty.elim" in "Empty"

NewDefinition Empty Empty.elim

/-- `This is impossible because of e` finishes any goal, whether a proposition or a type, from something that cannot exist: an element `e : Empty`, a proof `h : False`, or a contradiction such as `h applied to p` with `h : ¬ P` and `p : P` (Negation World). -/
TacticDoc «This»

NewTactic «This»
