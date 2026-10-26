import Game.Levels.ProductWorld.L03_SecondProjection

World "ProductWorld"
Level 4

Title "Symmetry"

/--
For types `A` and `B`, the function `Prod.swap : A × B → B × A` can be thought of as the function that sends a pair `⟨a, b⟩` to the pair `⟨b, a⟩`.
-/
DefinitionDoc Prod.swap as "swap" in "Prod"

Introduction "
The product type comes with function of type `A × B → B × A` which swaps the elements of an ordered pair.

This function can be defined by using the elimination rule for product types to map out of `A × B` followed by the introduction rule for product types to map into `B × A`.

The swap function can be defined by introducing a variable `p : A × B`, projecting to its components `p.1 : A` and `p.2 : B`, then reassembling these to give an element of type `B × A`.

There is also a sentence that takes a pair apart in one go. Given `p : A × B`, writing `By p we get a : A and b : B` adds the two components to your context under the names `a` and `b`. (You may write `By p we get a and b` and let Lean work out the types.) Sentences starting with `By` are now in your library.

Can you define this function?"


/-- Product types are symmetric: an element of type `A × B` has a corresponding element of type `B × A` with components swapped. -/
Statement {A B : Type} : A × B → B × A := by
  Hint (hidden := true) "The goal is a term of a function type so write `Fix p : A × B` to give yourself a term `p : A × B`."
  Fix p : A × B
  Hint (hidden := true) "Now the goal is an element of a product type. How can such elements be defined?"
  By p we get a : A and b : B
  Let's use ⟨b, a⟩

Conclusion "Lean calls the function you have just defined `Prod.swap`. It is now part of your library of definitions. Try solving this level again without `By`, using `Let's use ⟨p.2, p.1⟩`. Are function types symmetric? Why or why not?"

-- "The function just defined is sometimes called `swap` and is now part of the library of definitions on the right."
--  If you solved this level with `cases` or `rcases`, try solving it without, and conversely."

/-- Sentences starting with `By` use a hypothesis or element from your context by name:

* `By p we get a : A and b : B` takes a pair `p : A × B` apart into its components (also `By p we get a and b`, or with several components `By p we get (a : A) (b : B) (c : C)`). The same sentence takes apart a proof of a conjunction `h : P ∧ Q` or of an existential statement (`By h we get x such that hx : P x`), as we will see in later worlds.
* `By h applied to a we get hPa : P a` specialises `h : ∀ x, P x`.
* `By h it suffices to prove that P` uses an implication `h : P ⇒ Q` backwards. -/
TacticDoc «By»

NewTactic «By»

NewDefinition Prod.swap
