# Notes for coding agents

This repository is the **Verbose Lean edition** of Emily Riehl's lean4game *Reintroduction to
Proofs*: the same 159 levels and statements as
[emilyriehl/ReintroductionToProofs](https://github.com/emilyriehl/ReintroductionToProofs), played
in Verbose Lean's controlled English instead of Lean tactics. It is public on
<https://adam.math.hhu.de/#/g/emilyriehl/VerboseReintroductionToProofs>.

**Read [docs/handoff/README.md](docs/handoff/README.md) first.** It is a complete handoff written
for an agent with no prior context: what exists, why it was built this way, how to maintain it,
what is still open, and how Emily likes to work.

## House rules (details in docs/handoff/working-with-emily.md)

- The mathematics is shared with the original game and checked by `scripts/check_parity.py`.
  Statements, level lists and the world graph change upstream first, never here alone.
- Never edit Emily's own checkout of the original game. Upstream changes are prepared as
  branches in a separate clone and opened as pull requests only with her approval.
- Never push to `PatrickMassot/verbose-lean4` or `leanprover-community/lean4game`. Prepare the
  patch and the description; Emily opens those herself.
- Pushing to this repository is allowed. Read the complete diff of every commit before pushing.
- Do not run `lake build` while Emily is playing the local dev server, and run heavy jobs
  (builds, replays, browser playthroughs) one at a time: her laptop overheats.
- Commits made by an agent end with a `Co-Authored-By:` line naming the agent; pull request
  descriptions say which agent generated them.

## Everyday commands

    lake exe cache get && lake build                 # first build (Mathlib cache), ~10 min
    lake build                                       # after edits; regenerates .i18n/en/Game.pot
    python3 scripts/run_level.py . ProductWorld 3 tests/replays/P3.txt   # replay one input
    python3 scripts/replay_all.py                    # replay all recorded inputs (serial, ~45 min)
    python3 scripts/check_parity.py <checkout of the original at UPSTREAM_COMMIT> . --allowlist parity-allowlist.txt
    npm start   # in a lean4game clone next to this folder → http://localhost:3000/#/g/local/VerboseReintroductionToProofs
