import Game.Levels.ImplicationWorld.L09_ModusPonensAgain

World "ImplicationWorld"
Level 10

Title "Boss Level"

Introduction "We are now ready for the Boss Level of Implication World.

Multiple hypotheses can be introduced at once by writing `Assume (h1 : _) (h2 : _) (h3 : _)` etc. You might consider using names that will help you remember which propositions are proven by each hypothesis!

While it is not necessary to solve this level, you may enjoy experimenting with the sentence `Fact` that was recently added to the library.

To delete a proof (or proof attempt) and start over click on the button labelled `</>` in the upper right hand corner to enter `editor mode`. Then delete all the lines of your first proof (or proof attempt). Clicking on `>_` takes you back to `typewriter mode`."

/-- If `S ⇒ X`, `T ⇒ W`, `R ⇒ Y`, `W ⇒ Q`, `U ⇒ S`, `Y ⇒ T`, `X ⇒ V`, `Q ⇒ U`, `V ⇒ Z` and `P ⇒ R` are true then `P` implies `Z`. -/
Statement {P Q R S T U V W X Y Z : Prop} : (S → X) → (T → W) → (R → Y) → (W → Q) → (U → S) → (Y → T) → (X → V) → (Q → U) → (V → Z) → (P → R)
    → P → Z := by
  Assume sx : S → X
  Assume tw : T → W
  Assume ry : R → Y
  Assume wq : W → Q
  Assume us : U → S
  Assume yt : Y → T
  Assume xv : X → V
  Assume qu : Q → U
  Assume vz : V → Z
  Assume pr : P → R
  Assume p : P
  We apply vz
  We apply xv
  We apply sx
  We apply us
  We apply qu
  We apply wq
  We apply tw
  We apply yt
  We apply ry
  We apply pr
  We conclude by p

Conclusion "Next move on to Product World to meet a second type forming operation, which will again have a corresponding logical connective."
