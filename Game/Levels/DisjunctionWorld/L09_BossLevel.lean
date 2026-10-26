import Game.Levels.DisjunctionWorld.L08_MoreDistributivity

World "DisjunctionWorld"
Level 9

Title "Disjunction Boss Level"

Introduction "We've now reached the Boss Level in the Disjunction World.

This level illustrates that proofs by cases can be somewhat delicate.

Have fun!
"

/-- If `T ∨ U ⇒ V ∧ Y` and `Q ⇒ P ⇒ T` and `Y ⇒ Q ⇒ W` and
`(V ∧ W) ∨ (X ∧ Y) ⇒ Z` and `(R ⇒ S ⇒ U) ∧ (V ⇒ R ⇒ X)` then  `P ∧ (Q ∨ R) ∧ S` implies `Z`. -/
Statement {P Q R S T U V W X Y Z : Prop} : (T ∨ U → V ∧ Y) → (Q → P → T) → (Y → Q → W) →
((V ∧ W) ∨ (X ∧ Y) → Z) → (R → S → U) ∧ (V → R → X) →  P ∧ (Q ∨ R) ∧ S →
Z := by
  Assume (f : T ∨ U → V ∧ Y) (g : Q → P → T) (h : Y → Q → W) (j : (V ∧ W) ∨ (X ∧ Y) → Z) (k : (R → S → U) ∧ (V → R → X)) (pqrs : P ∧ (Q ∨ R) ∧ S)
  We apply j
  By pqrs we get (p : P) (qr : Q ∨ R) (s : S)
  Let's first consider the case where qr is inl q
  Let's prove that V ∧ W
  Claim t : T from g applied to q and p
  By f applied to Or.inl t we get v : V and y : Y
  Claim w : W from h applied to y and q
  We conclude by ⟨v, w⟩
  Let's next consider the case where qr is inr r
  Let's prove that X ∧ Y
  Claim u : U from k.1 applied to r and s
  By f applied to Or.inr u we get v : V and y : Y
  Claim x : X from k.2 applied to v and r
  We conclude by ⟨x, y⟩

Conclusion "The next topic in our study of propositional logic is *negation*, which is used to assert that a proposition is false rather than true. But to help us understand it, move on to Empty World to learn about the empty type."
