import Verbose.English.All

/-! # `help` with plain-text output, aware of the current level

Verbose's `help` emits its suggestions as Lean "Try this" widgets. The game server's message
panel cannot render those and shows `malformed MsgEmbed: {...}` instead. This file provides a
`help` that prints the same suggestions as plain text. `Game/Metadata.lean` disables Verbose's own
`help` so that this one is the only alternative that succeeds.

The suggestions are also filtered by what the game has taught so far. Verbose's help providers
only look at the goal, so in Function World level 2 they would happily propose `We apply f`, a
sentence the game introduces one level later. The current level is read off the module that the
game server imports for the player's proof (`Game.Levels.<World>.L<nn>_…`), the world graph comes
from `.lake/gamedata/game.json`, and `taughtAt` below records where each sentence is introduced. -/

open Lean Meta Elab Tactic Verbose Lean.Meta.Tactic.TryThis

namespace GameHelp

/-- Where each sentence is introduced: a prefix of the suggestion text, the world and the level.
Later entries are checked first when several prefixes match (the longer phrase wins). -/
def taughtAt : List (String × String × Nat) := [
  ("Let's use", "TypeWorld", 1),
  ("We conclude by", "TypeWorld", 2),
  ("Fix", "FunctionWorld", 1),
  ("We apply", "FunctionWorld", 3),
  ("By", "FunctionWorld", 3),                       -- `By h it suffices to prove that …`
  ("Claim", "ImplicationWorld", 4),
  ("Assume", "ImplicationWorld", 5),
  ("Let's construct the pair", "ProductWorld", 1),
  ("Let's construct it componentwise", "ProductWorld", 1),
  ("Set", "ProductWorld", 9),
  ("Let's first prove that", "ConjunctionWorld", 1),
  ("Let's now prove that", "ConjunctionWorld", 1),
  ("Let's construct an element of", "CoproductWorld", 1),
  ("Let's consider", "CoproductWorld", 4),
  ("Let's first consider", "CoproductWorld", 4),
  ("Let's next consider", "CoproductWorld", 4),
  ("Let's prove that", "DisjunctionWorld", 1),      -- choosing a disjunct
  ("We proceed using", "DisjunctionWorld", 3),
  ("This is impossible", "EmptyWorld", 1),
  ("Let's prove it's contradictory", "NegationWorld", 5),
  ("Assume for contradiction", "ClassicalWorld", 1),
  ("We discuss depending on whether", "ClassicalWorld", 3),
  ("We rewrite using", "EqualityWorld", 4),
  ("Let's prove that … works", "QuantifierWorld", 4),  -- matched specially below
  ("By funext", "AdvancedFunctionWorld", 13),
  ("Let's construct it componentwise", "EquivalenceWorld", 1),
  ("We compute", "NaturalNumbersWorld", 2),
  ("Let's prove by induction", "NaturalNumbersWorld", 3),
  ("Let's define it by recursion", "NaturalNumbersWorld", 4)]

/-- The level a suggestion is first taught in, if the sentence is one the game teaches. -/
def introducedAt (suggestion : String) : Option (String × Nat) := Id.run do
  let s := suggestion.trim
  if s.startsWith "Let's prove that" && (s.endsWith "works" || (s.splitOn " works").length > 1) then
    return some ("QuantifierWorld", 4)
  if s.startsWith "By " && (s.splitOn " we get ").length > 1 then
    return some ("ProductWorld", 4)
  let mut best : Option (String × String × Nat) := none
  for (pre, w, n) in taughtAt do
    if s.startsWith pre then
      match best with
      | some (bpre, _, _) => if pre.length ≥ bpre.length then best := some (pre, w, n)
      | none => best := some (pre, w, n)
  return best.map fun (_, w, n) => (w, n)

/-- The world and level of the proof being checked, read off the imported level module
`Game.Levels.<World>.L<nn>_<Name>`. -/
def currentLevel (env : Environment) : Option (String × Nat) := Id.run do
  for imp in env.header.imports do
    match imp.module.components with
    | [`Game, `Levels, w, l] =>
      let l := l.toString
      if l.startsWith "L" then
        let digits := (l.drop 1).takeWhile Char.isDigit
        if let some n := digits.toNat? then return some (w.toString, n)
    | _ => pure ()
  return none

/-- The dependency edges `(prerequisite, world)` of the game, from the built game data. -/
def worldEdges : IO (Array (String × String)) := do
  try
    let json ← Json.parse (← IO.FS.readFile ".lake/gamedata/game.json") |> IO.ofExcept
    let edges ← (json.getObjVal? "worlds" >>= (·.getObjVal? "edges") >>= (·.getArr?)) |> IO.ofExcept
    let mut out := #[]
    for e in edges do
      if let .ok #[a, b] := e.getArr? then
        if let (.ok a, .ok b) := (a.getStr?, b.getStr?) then out := out.push (a, b)
    return out
  catch _ => return #[]

/-- All worlds that must be completed before `world` (transitively). -/
partial def ancestors (edges : Array (String × String)) (world : String) : List String :=
  go [world] []
where
  go (todo : List String) (acc : List String) : List String :=
    match todo with
    | [] => acc
    | w :: rest =>
      let parents := edges.toList.filterMap fun (a, b) => if b == w && !acc.contains a then some a else none
      go (rest ++ parents) (acc ++ parents)

/-- Is a sentence introduced at `(w', n')` available in level `(w, n)`? -/
def available (edges : Array (String × String)) (here : String × Nat) (intro : String × Nat) : Bool :=
  (intro.1 == here.1 && intro.2 ≤ here.2) || (ancestors edges here.1).contains intro.1

end GameHelp

open GameHelp in
elab "help" h:(colGt ident)? : tactic => do
  let (s, msg) ← match h with
    | some h => gatherSuggestions (helpAtHyp (← getMainGoal) h.getId)
    | none => gatherSuggestions (helpAtGoal (← getMainGoal))
  if s.isEmpty then
    logInfo (msg.getD "No suggestion")
    return
  -- Keep the suggestions the game has taught by now.
  let here? := currentLevel (← getEnv)
  let edges ← if here?.isSome then worldEdges else pure #[]
  let mut kept : Array Suggestion := #[]
  let mut dropped := 0
  for sug in s do
    let text ← sug.suggestion.prettyExtra   -- the sentence as the player would type it
    match here?, introducedAt text with
    | some here, some intro => if available edges here intro then kept := kept.push sug else dropped := dropped + 1
    | some _, none => dropped := dropped + 1          -- a sentence the game never teaches
    | none, _ => kept := kept.push sug                 -- unknown level: show everything
  if kept.isEmpty then
    logInfo m!"No suggestion yet: the sentences that would apply here are introduced in later levels."
    return
  let mut out : MessageData := m!"Help"
  for sug in kept do
    let pre := (sug.preInfo?.getD "").trimRight
    let post := (sug.postInfo?.getD "").trimRight
    out := out ++ m!"\n• {pre}\n    {toMessageData sug.suggestion}"
    unless post.isEmpty do out := out ++ m!"\n  {post}"
  if dropped > 0 then
    out := out ++ m!"\n(Some other sentences would also work here; they are introduced in later levels.)"
  logInfo out
