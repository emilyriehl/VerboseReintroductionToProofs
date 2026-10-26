import Verbose.English.All

/-! # `help` with plain-text output

Verbose's `help` emits its suggestions as Lean "Try this" widgets. The game server's message
panel cannot render those and shows `malformed MsgEmbed: {...}` instead. This file provides a
`help` that prints the same suggestions as plain text. `Game/Metadata.lean` disables Verbose's own
`help` so that this one is the only alternative that succeeds. -/

open Lean Meta Elab Tactic Verbose Lean.Meta.Tactic.TryThis

elab "help" h:(colGt ident)? : tactic => do
  let (s, msg) ← match h with
    | some h => gatherSuggestions (helpAtHyp (← getMainGoal) h.getId)
    | none => gatherSuggestions (helpAtGoal (← getMainGoal))
  if s.isEmpty then
    logInfo (msg.getD "No suggestion")
  else
    let mut out : MessageData := m!"Help"
    for sug in s do
      let pre := (sug.preInfo?.getD "").trimRight
      let post := (sug.postInfo?.getD "").trimRight
      out := out ++ m!"\n• {pre}\n    {toMessageData sug.suggestion}"
      unless post.isEmpty do out := out ++ m!"\n  {post}"
    logInfo out
