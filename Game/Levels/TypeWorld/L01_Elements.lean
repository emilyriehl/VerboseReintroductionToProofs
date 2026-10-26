import Game.Metadata

World "TypeWorld"
Level 1

Title "Elements"

Introduction "An interactive theorem prover &mdash; in this case Lean &mdash; helps the user &mdash; this means you &mdash; keep track of the state of a proof or a mathematical construction.

In the `Active Goal` window, Lean keeps track of the `objects` and `assumptions` &mdash; which together define the hypotheses of a mathematical statement &mdash; as well as the `goal` &mdash; meaning the thing we are trying to prove.

The objects and assumptions together define the mathematical *context* for a given theorem or construction.

Here our context is given by a single type `A` with a hypothesized element `a : A`.

On the right-hand side we see the name of a type, which is the *goal* for this level. Here that type is `A`, which means that our goal is to define an element of type `A`.

We have such an element by assumption, and you can tell Lean this by writing the sentence `Let's use an assumption`. Then press `enter` or click the button `Execute` to ask Lean to check your work.

In this game you talk to Lean in short English sentences like this one. Each sentence is checked by the computer, so it has to be written exactly as shown (capital letter at the start, no period at the end). The sentences you have learned so far are listed in the library on the upper right, under the word they start with; `Let's use an assumption` is listed under `Let's`.

One more sentence is available from the start: `help`, on a line by itself, asks Lean which sentences apply to the current goal."

/-- Under the hypothesis that we have a type `A` and an element `a : A`, we may define an element of `A`.-/
Statement {A : Type} (a : A) : A := by
  Hint (hidden := true) "Write `Let's use an assumption` to tell Lean to use the assumed element of `A` to define an element of `A`."
  Let's use an assumption

Conclusion "In the next level, we will learn about elements of propositions."

/-- Sentences starting with `Let's` announce what you are about to do:

* `Let's use an assumption` closes the goal with whichever element or proof in your context has the right type.
* `Let's use e` closes the goal with the element or proof `e` (you name it).
* `Let's prove that P`, `Let's first prove that P` / `Let's now prove that Q`, `Let's prove that x works`, `Let's prove by induction that _`: for proofs, introduced in later worlds.
* `Let's construct it componentwise`, `Let's construct an element of A`, `Let's consider all cases for b`, `Let's first consider the case where b is …`, `Let's define it by recursion on n`: for constructions, introduced in later worlds. -/
TacticDoc «Let's»

/-- Write `help` on a line by itself and Lean lists the sentences that apply to the current goal, with the statements filled in. `help h` does the same for a hypothesis `h`. -/
TacticDoc help

NewTactic «Let's» help

/-- Part of a Verbose phrase (word `and`). -/
TacticDoc «and»
/-- Part of a Verbose phrase (word `applied`). -/
TacticDoc «applied»
/-- Part of a Verbose phrase (word `apply`). -/
TacticDoc «apply»
/-- Part of a Verbose phrase (word `as`). -/
TacticDoc «as»
/-- Part of a Verbose phrase (word `assumption`). -/
TacticDoc «assumption»
/-- Part of a Verbose phrase (word `becomes`). -/
TacticDoc «becomes»
/-- Part of a Verbose phrase (word `choose`). -/
TacticDoc «choose»
/-- Part of a Verbose phrase (word `combine`). -/
TacticDoc «combine»
/-- Part of a Verbose phrase (word `computation`). -/
TacticDoc «computation»
/-- Part of a Verbose phrase (word `conclude`). -/
TacticDoc «conclude»
/-- Part of a Verbose phrase (word `contradicting`). -/
TacticDoc «contradicting»
/-- Part of a Verbose phrase (word `contradiction`). -/
TacticDoc «contradiction»
/-- Part of a Verbose phrase (word `contradictory`). -/
TacticDoc «contradictory»
/-- Part of a Verbose phrase (word `contrapose`). -/
TacticDoc «contrapose»
/-- Part of a Verbose phrase (word `contrapositive:`). -/
TacticDoc «contrapositive:»
/-- Part of a Verbose phrase (word `depending`). -/
TacticDoc «depending»
/-- Part of a Verbose phrase (word `discuss`). -/
TacticDoc «discuss»
/-- Part of a Verbose phrase (word `everywhere`). -/
TacticDoc «everywhere»
/-- Part of a Verbose phrase (word `finally`). -/
TacticDoc «finally»
/-- Part of a Verbose phrase (word `first`). -/
TacticDoc «first»
/-- Part of a Verbose phrase (word `for`). -/
TacticDoc «for»
/-- Part of a Verbose phrase (word `forget`). -/
TacticDoc «forget»
/-- Part of a Verbose phrase (word `from`). -/
TacticDoc «from»
/-- Part of a Verbose phrase (word `get`). -/
TacticDoc «get»
/-- Part of a Verbose phrase (word `hence`). -/
TacticDoc «hence»
/-- Part of a Verbose phrase (word `hypothesis`). -/
TacticDoc «hypothesis»
/-- Part of a Verbose phrase (word `induction`). -/
TacticDoc «induction»
/-- Part of a Verbose phrase (word `it`). -/
TacticDoc «it»
/-- Part of a Verbose phrase (word `it's`). -/
TacticDoc «it's»
/-- Part of a Verbose phrase (word `negation`). -/
TacticDoc «negation»
/-- Part of a Verbose phrase (word `now`). -/
TacticDoc «now»
/-- Part of a Verbose phrase (word `next`). -/
TacticDoc «next»
/-- Part of a Verbose phrase (word `observe`). -/
TacticDoc «observe»
/-- Part of a Verbose phrase (word `obtain`). -/
TacticDoc «obtain»
/-- Part of a Verbose phrase (word `on`). -/
TacticDoc «on»
/-- Part of a Verbose phrase (word `or`). -/
TacticDoc «or»
/-- Part of a Verbose phrase (word `proceed`). -/
TacticDoc «proceed»
/-- Part of a Verbose phrase (word `prove`). -/
TacticDoc «prove»
/-- Part of a Verbose phrase (word `push`). -/
TacticDoc «push»
/-- Part of a Verbose phrase (word `reformulate`). -/
TacticDoc «reformulate»
/-- Part of a Verbose phrase (word `rename`). -/
TacticDoc «rename»
/-- Part of a Verbose phrase (word `rewrite`). -/
TacticDoc «rewrite»
/-- Part of a Verbose phrase (word `simply`). -/
TacticDoc «simply»
/-- Part of a Verbose phrase (word `since`). -/
TacticDoc «since»
/-- Part of a Verbose phrase (word `since?`). -/
TacticDoc «since?»
/-- Part of a Verbose phrase (word `such`). -/
TacticDoc «such»
/-- Part of a Verbose phrase (word `suffices`). -/
TacticDoc «suffices»
/-- Part of a Verbose phrase (word `that`). -/
TacticDoc «that»
/-- Part of a Verbose phrase (word `the`). -/
TacticDoc «the»
/-- Part of a Verbose phrase (word `to`). -/
TacticDoc «to»
/-- Part of a Verbose phrase (word `unfold`). -/
TacticDoc «unfold»
/-- Part of a Verbose phrase (word `we`). -/
TacticDoc «we»
/-- Part of a Verbose phrase (word `whether`). -/
TacticDoc «whether»
/-- Part of a Verbose phrase (word `which`). -/
TacticDoc «which»
/-- Part of a Verbose phrase (word `works`). -/
TacticDoc «works»
/-- Part of a Verbose phrase (word `use`). -/
TacticDoc «use»
/-- Part of a Verbose phrase (word `an`). -/
TacticDoc «an»
/-- Part of a Verbose phrase (word `element`). -/
TacticDoc «element»
/-- Part of a Verbose phrase (word `of`). -/
TacticDoc «of»
/-- Part of a Verbose phrase (word `construct`). -/
TacticDoc «construct»
/-- Part of a Verbose phrase (word `componentwise`). -/
TacticDoc «componentwise»
/-- Part of a Verbose phrase (word `pair`). -/
TacticDoc «pair»
/-- Part of a Verbose phrase (word `consider`). -/
TacticDoc «consider»
/-- Part of a Verbose phrase (word `all`). -/
TacticDoc «all»
/-- Part of a Verbose phrase (word `cases`). -/
TacticDoc «cases»
/-- Part of a Verbose phrase (word `case`). -/
TacticDoc «case»
/-- Part of a Verbose phrase (word `where`). -/
TacticDoc «where»
/-- Part of a Verbose phrase (word `is`). -/
TacticDoc «is»
/-- Part of a Verbose phrase (word `define`). -/
TacticDoc «define»
/-- Part of a Verbose phrase (word `recursion`). -/
TacticDoc «recursion»
/-- Part of a Verbose phrase (word `impossible`). -/
TacticDoc «impossible»
/-- Part of a Verbose phrase (word `because`). -/
TacticDoc «because»
/-- Part of a Verbose phrase (word `Calc?`). -/
TacticDoc «Calc?»
/-- `Type` and `Sort` may appear inside the element you supply (`Let's use Type` is an instructive error). -/
TacticDoc «Type»
/-- See `Type`. -/
TacticDoc «Sort»

-- The game checks each sentence word by word against the library. Every word of every
-- sentence must be allowed; these are the words that are not themselves the first word of a
-- library entry. Declared once here, they are available in all later levels.
NewHiddenTactic «and» «applied» «apply» «as» «assumption» «becomes» «choose» «combine» «computation» «conclude» «contradicting» «contradiction» «contradictory» «contrapose» «contrapositive:» «depending» «discuss» «everywhere» «finally» «first» «for» «forget» «from» «get» «hence» «hypothesis» «induction» «it» «it's» «negation» «now» «next» «observe» «obtain» «on» «or» «proceed» «prove» «push» «reformulate» «rename» «rewrite» «simply» «since» «since?» «such» «suffices» «that» «the» «to» «unfold» «we» «whether» «which» «works» «use» «an» «element» «of» «construct» «componentwise» «pair» «consider» «all» «cases» «case» «where» «is» «define» «recursion» «impossible» «because» «Calc?» «We» «Type» «Sort»
