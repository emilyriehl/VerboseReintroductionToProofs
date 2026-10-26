import Game.Levels.ConjunctionWorld.L09_UniversalProperty

World "ConjunctionWorld"
Level 10

Title "Boss Level"

Introduction
"
For the Boss Level of Conjunction World, the task is to prove a complicated implication.

After introducing all of the allowed hypotheses, you may find it helpful to prove that some intermediate propositions are true using `Claim`.

Good luck!
"

/-- If `P`, `R ⇒ S ∧ T`, `U ⇒ P ⇒ R`, `(U ⇒ Y) ⇒ Z`, `W ∧ T ∧ V ⇒ X ∧ Y`, and `S ⇒ V ∧ W` are true, then `Z` is true. -/
Statement {P Q R S T U V W X Y Z : Prop} : P → (R → S ∧ T) → (U → P → R) → ((U → Y) → Z) → (W ∧ T ∧ V → X ∧ Y) → (S → V ∧ W) → Z := by
  Assume (p : P) (h : R → S ∧ T) (k : U → P → R) (l : (U → Y) → Z) (g : W ∧ T ∧ V → X ∧ Y) (f : S → V ∧ W)
  We apply l
  Assume u : U
  We conclude by (g ⟨(f (h (k u p)).1).2, (h (k u p)).2 , (f (h (k u p)).1).1⟩).2

Conclusion "Next move on to Coproduct World to learn about another type forming operation, which is in some sense &ldquo;dual&rdquo; to product types."
