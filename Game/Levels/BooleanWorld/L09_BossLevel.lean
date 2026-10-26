import Game.Levels.BooleanWorld.L08_NotEqual

World "BooleanWorld"
Level 9

Title "Boss Level"

Introduction "
An expression involving booleans is in *conjuctive normal form* if it expressed as a conjunction (possibly involving many formulas) of disjunctions (possibly involving many formulas) of either booleans or their negations.

Using Lean's alternate notation for conjunction, disjunction, and negation, conjunctive normal form statements look like

`(p || !q || r) && (q || !r) && (!p || r)`

For the Boss Level, you are asked to find booleans `p q r : Bool` so that

`(!p || q) && (!q || p) && (!p || !r) && (!q || !r) && (p || q)`

is satisfiable, meaning that the after substituting appropriate elements for `p q r`, this conjunctive normal form formula is equal to `true`.

You can see this expression in the fourth goal, with `p`, `q`, and `r` standing in for the yet-to-be-determined boolean variables.

Solve the first three goals by `Let's use p`, `Let's use q`, and `Let's use r` &mdash; replacing the boolean variables by explicit booleans `true` or `false` as appropriate. If you have found the right solution, the final goal should be solvable with `We conclude by rfl`.
"

/-- The following expression in conjunctive normal form is satisfiable. -/
Statement (preamble := refine let p := ?p; let q := ?q; let r := ?r ;  ⟨p, q, r, ?eq⟩) :
    ∃ p : Bool, ∃ q : Bool, ∃ r : Bool,
    Bool.and (not p || q)
    (Bool.and (not q || p)
    (Bool.and (not p || not r)
    (Bool.and (not q || not r)
    (p || q)))) = true := by
  Let's use true
  Let's use true
  Let's use false
  We conclude by rfl

Conclusion "If this was too easy, you might find it interesting to learn that the general problem of identifying whether a formula in conjunctive normal form is satisfiable is NP complete! Move on to Quantifier World to meet the universal and existential quantifiers."
