import Verbose.English.All
import Mathlib.Tactic.Constructor

/-! # Prototype construction phrases

Verbose Lean only has a vocabulary for *proving* propositions. Reintroduction to Proofs also asks
players to *construct* elements of types (`A × B`, `A ⊕ B`, `A ≃ B`, …). These phrases are
written in Verbose's own style (multi-word atoms are split into tokens by Verbose's `syntax`
macro) so that they read like the rest of the game's language.

Phrasing is provisional; it is here to test the mechanism. -/

open Lean Elab Tactic Verbose.English

/-- `Let's construct the pair`: when the goal is a product type `A × B` (or any other
structure), split it into one goal per component, in order. -/
elab "Let's" " construct the pair" : tactic => do
  evalTactic (← `(tactic| fconstructor))

/-- `Let's construct it componentwise`: same as `Let's construct the pair`, for any structure
(`A × B`, `Σ`, `A ≃ B`, …). -/
elab "Let's" " construct it componentwise" : tactic => do
  evalTactic (← `(tactic| fconstructor))

/-- `Let's construct an element of A`: when the goal is a sum `A ⊕ B`, choose the summand `A`
(or `B`); the new goal is to construct an element of that summand. Also accepted when the goal
already is `A`. -/
elab "Let's" " construct an element of " t:term : tactic => withMainContext do
  -- `withoutRecover`: otherwise a failed attempt is *logged* (and the goal closed by `sorry`)
  -- instead of raising an exception we can catch.
  let attempt (tac : TSyntax `tactic) : TacticM Unit := withoutRecover (evalTactic tac)
  try attempt (← `(tactic| refine (?_ : $t)))
  catch _ =>
  try attempt (← `(tactic| refine Sum.inl (?_ : $t)))
  catch _ =>
  try attempt (← `(tactic| refine Sum.inr (?_ : $t)))
  catch _ => throwError m!"The goal is neither {t} nor a sum type having {t} as one of its summands."

/-- `This is impossible because of e`: close any goal from `e : Empty`, `h : False`, a
contradiction such as `h applied to p` with `h : ¬ P` and `p : P`, or an impossible equation such as
`p : false = true`. -/
elab "This is impossible because of " e:maybeApplied : tactic => withMainContext do
  let t ← maybeAppliedToTerm e
  try withoutRecover <| evalTactic (← `(tactic| first | exact Empty.elim $t | exact False.elim $t | exact absurd $t (by assumption) | (cases $t:term; done) | exact nomatch $t))
  catch _ => throwError m!"{t} is not an impossibility: it should be an element of `Empty`, a proof of `False`, or a contradiction."
