import Game.Levels.ProductWorld.L09_UniversalProperty

World "ProductWorld"
Level 10

Title "Boss Level"

Introduction "The objective of this Boss Level is to define a function that takes five variables as inputs and has three
variables as outputs by combining the data of four simpler functions.

This function is defined as a composite &mdash; in a much more complicated sense than we have seen thus far &mdash; of the given functions.

Can you do it?

The sentence `Set`, which is now in your library, may be helpful for making partial progress.
"

/-- Given functions of types `B × D → M`, `E → Y × N`, `A → M → X`, and `C → N → Z`, there is a function from the product type `A × B × C × D × E` to the product type `X × Y × Z`. -/
Statement {A B C D E M N X Y Z : Type} :
  (B × D → M) → (E → Y × N) → (A → M → X) → (C → N → Z) → (A × B × C × D × E → X × Y × Z):= by
  Fix (f : B × D → M) (g : E → Y × N) (h : A → M → X) (k : C → N → Z) (p : A × B × C × D × E)
  Set a := p.1
  Set b := p.2.1
  Set c := p.2.2.1
  Set d := p.2.2.2.1
  Set e := p.2.2.2.2
  Let's construct the pair
  We apply h
  Let's use a
  We apply f
  Let's construct the pair
  Let's use b
  Let's use d
  Let's construct the pair
  Let's use (g e).1
  We apply k
  Let's use c
  Let's use (g e).2

Conclusion "The sentence `By` can also decompose an element of an iterated product type into all of its components at once. For example, using an element `p : A × B × C × D × E`, writing `By p we get (a : A) (b : B) (c : C) (d : D) (e : E)` will add elements `a : A`, `b : B`, `c : C`, `d : D`, and `e : E` to your context.

Move on to Conjunction World to learn about the logical operation that is analogous to product types."

-- "You may be wondering about the relationship between terms `p : A × B` and `⟨p.1, p.2⟩ : A × B`. To be able to answer this and similar questions, move on to Euuality World."

-- Conclusion "Congratulations! In the next world, we'll introduce another type forming operation that
-- is *dual* to product types in a certain sense."
