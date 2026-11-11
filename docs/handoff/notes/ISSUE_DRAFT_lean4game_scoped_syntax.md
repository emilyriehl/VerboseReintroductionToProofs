# Draft issue for leanprover-community/lean4game (Emily opens it)

Title: Scoped syntax/notation from a level file's `open` is not available to the player

A level file can `open` a namespace before its `Statement`, and `GameServer.Runner` re-applies
those `openDecls` (and calls `activateScoped`) when it elaborates the player's proof. That makes
*names* from the namespace resolve (e.g. `open Classical` → `byContradiction`), but `scoped
syntax` and `scoped notation` from that namespace are still unavailable to the player: the
`Runner … := by <tactics>` command is parsed before its elaborator runs, so at parse time none of
the level's scopes are active.

Concrete case: Verbose Lean (https://github.com/PatrickMassot/verbose-lean4) puts its phrases
that name hypotheses, e.g. `Assume h : P`, behind `scoped syntax` in `Verbose.Named`. With
`open Verbose.Named` in the level file and the sample proof building fine, a player typing
`Assume p : P` gets `unexpected identifier; expected 'for' or 'that'`. Prepending
`open Verbose.Named` to the document the relay generates makes it work. math-atlas-lean hit the
same wall with scoped notation and worked around it by defining global notation.

Possible fix: export the level's `openDecls` (names only) into `level__World__N.json` from
`MakeGame`, and have `relay/src/serverProcess.ts` emit one `open <ns>` line per entry between the
`import` line and the `Runner` line (adjusting `PROOF_START_LINE` accordingly). Alternatively a
`LevelScope`-style command where a game lists namespaces to open for the player.

Happy to send a PR if the approach sounds right.
