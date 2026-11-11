# Zulip draft: Reintroduction to Proofs, Verbose Lean edition

Reintroduction to Proofs now exists in a second version whose player language is Verbose Lean's
controlled English instead of tactics: `Fix a : A`, `Assume h : P`, `Claim q : Q from h applied
to p`, `We conclude by h`, `Let's prove that b works`, plus a few game-specific sentences for the
type-theoretic levels (`Let's use a`, `Let's construct the pair`, `Let's consider all cases for b`,
`This is impossible because of e`). Same 159 levels and statements as the original; a CI check
keeps the two in sync, and upstream edits flow into the verbose version automatically.

Play: https://adam.math.hhu.de/#/g/emilyriehl/VerboseReintroductionToProofs
Source: https://github.com/emilyriehl/VerboseReintroductionToProofs (issues and PRs welcome)
Original: https://adam.math.hhu.de/#/g/emilyriehl/ReintroductionToProofs

Built on Verbose Lean (Patrick Massot) and lean4game, Lean v4.31.0.

## Upstream suggestions found along the way

verbose-lean4
- Rename the `gameExt` environment extension (clashes with lean4game's GameServer); patch on
  branch `lean4game-compat` of emilyriehl/verbose-lean4, draft in PR_DRAFT_verbose_gameExt.md.
- Optional later: the construction sentences for data goals, if there is interest.

lean4game (all present on `main` as of the v4.35 bump; adam's deployed client is an earlier
generation and showed neither the unlock nor the world-change problem when tested on 2026-10-27)
- World unlock checks the wrong world (`worldDependenciesCompletedAtomFamily` tests `worldId`
  instead of the edge's source), so at "regular" no world after the first can be entered.
- Per-world document folders (`file:///<World>/<n>.lean`) make vscode-lean4 open a second Lean
  connection on a world change while the infoview keeps the first; proof-state requests then fail
  with "Level not found" until a reload. One folder for all levels fixes it; the relay should also
  send `didClose` before a new `didOpen` on the same connection.
- The dev client never sends `difficulty`/`inventory` in `initializationOptions`, so the relay
  falls back to difficulty 1 and an empty inventory.
- Spurious "level completed" in editor mode (issues #402/#453): completion should be checked
  against the goal state (adapted from PR #455).
- The Runner applies the level's `open` declarations after parsing the player's input, so scoped
  syntax (Verbose's named phrases) never reaches players; draft in ISSUE_DRAFT_lean4game_scoped_syntax.md.
- Inventory is matched word by word on alphabetic atoms; multi-word phrases need one hidden
  "tactic" per word, each with a doc entry. Matching by syntax kind would be cleaner.
