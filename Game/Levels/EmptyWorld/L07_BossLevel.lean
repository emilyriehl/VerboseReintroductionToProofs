import Game.Levels.EmptyWorld.L06_CoproductWithEmpty

World "EmptyWorld"
Level 7

Title "Boss Level"

Introduction "For the Boss Level of Empty World, we construct something that is just weird.

Your challenge is to define functions in both directions between types that are formed by iteratively applying certain type forming operations to the empty type.

Interestingly each of these types has an element, which can be used to define the functions if you wish.

There are other strategies to defining the funtions as well, so you may enjoy trying to solve this level in multiple ways.

Have fun!
"

open ReintroductionToProofs

/-- There are functions in both directions between the types `Empty ⊕ (Empty → Empty)` and `(Empty → Empty) × (Empty → Empty)`. -/
Statement : (Empty ⊕ (Empty → Empty) → (Empty → Empty) × (Empty → Empty)) × ((Empty → Empty) × (Empty → Empty) → Empty ⊕ (Empty → Empty))  := by
  Let's construct the pair
  Fix h : Empty ⊕ (Empty → Empty)
  Let's first consider the case where h is inl x
  This is impossible because of x
  Let's next consider the case where h is inr y
  Let's use ⟨y, y⟩
  Fix p : (Empty → Empty) × (Empty → Empty)
  Let's use Sum.inr p.2

Conclusion "The empty type is a weird type, so what was the point of this world? The hope is that your experience defining functions involving the empty type will prepare you to think about what it means to prove that a proposition is false in Negation World. Go there next."
