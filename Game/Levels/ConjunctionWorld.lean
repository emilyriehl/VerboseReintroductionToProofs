import Game.Levels.ConjunctionWorld.L01_IntroducingAnd
import Game.Levels.ConjunctionWorld.L02_UsingAnd
import Game.Levels.ConjunctionWorld.L03_Symmetry
import Game.Levels.ConjunctionWorld.L04_LogicalEquivalence
import Game.Levels.ConjunctionWorld.L05_Associativity
import Game.Levels.ConjunctionWorld.L06_CompoundImplication
import Game.Levels.ConjunctionWorld.L07_MoreCompoundImplication
import Game.Levels.ConjunctionWorld.L08_CurryingImplication
import Game.Levels.ConjunctionWorld.L09_UniversalProperty
import Game.Levels.ConjunctionWorld.L10_BossLevel

World "ConjunctionWorld"
Title "Conjunction World"

Introduction "
The logical connective of *conjunction*, denoted by `∧`, is the mathematical version of *and*.

For arbitrary propositions `P` and `Q`, `P ∧ Q` is a new proposition asserting that `P` *and* `Q` *are both true*.

To understand how conjunctions work in logic we must learn:

* How to prove theorems of the form `P ∧ Q`.
* How to use a hypothesis of the form `P ∧ Q` to prove something else.

To prove `P ∧ Q`, one must supply proofs `p : P` and `q : Q`. On paper one writes &ldquo;let us first prove `P` … and now let us prove `Q`&rdquo;; in this game the sentences are `Let's first prove that P` and `Let's now prove that Q`. The pair of proofs can also be written directly as `⟨p, q⟩ : P ∧ Q`, using `\\<` and `\\>` to type the angle brackets, and `\\and` to type `∧`.

If we have a proof `h : P ∧ Q` then we can extract proofs that `P` and `Q` are true: `By h we get hp : P and hq : Q` names them, and the syntax `h.1 : P` and `h.2 : Q` refers to them directly.

Like the analogy between function types and implication, there is a close analogy between product types and the logical operation of conjunction.

The reuse of the sentences and the syntax we first introduced for product types is deliberate, as the introduction and elimination rules for conjunctions precisely mirror those for product types: `Let's first prove that P` plays the role of `Let's construct the pair`, and `By h we get …` takes a proof of a conjunction apart just as it took a pair apart.
"
