# Contributing

This game is the Verbose Lean edition of [Reintroduction to Proofs](https://github.com/emilyriehl/ReintroductionToProofs).
The two games present the same levels and the same statements; they differ in the language the
player uses: Lean tactics there, Verbose Lean phrases here.

**Where to report what**

- A mathematical error, a confusing explanation of the *mathematics*, a typo in a world or level
  introduction that does not mention tactics or phrases: please open the issue or pull request in
  the [original repository](https://github.com/emilyriehl/ReintroductionToProofs/issues). The fix
  flows into this game through the weekly `sync-upstream` workflow.
- Anything about the Verbose phrases, their documentation, hints that mention phrases, or the
  game-specific phrases defined in `Game/Metadata/Tactic/`: open it here.

**Testing a level without the browser**

`scripts/run_level.py` replays a player's input through the game server's own `Runner`, exactly
as the website does:

    python3 scripts/run_level.py . ImplicationWorld 5 my_attempt.txt

**Keeping the two games aligned**

- `UPSTREAM_COMMIT` records the commit of the original this game was last merged with.
- `scripts/check_parity.py` (run by the `parity-check` workflow) fails when a `Statement`, level
  list or world graph differs from the original at that commit; deliberate differences go into
  `parity-allowlist.txt`.
- `lean-toolchain`, `lakefile.lean` and `lake-manifest.json` always keep this repository's
  versions when merging.
