# Reintroduction to Proofs — Verbose Lean edition

The same game as [Reintroduction to Proofs](https://github.com/emilyriehl/ReintroductionToProofs):
an informal introduction to proofs and constructions in dependent type theory, aimed at someone
learning to write abstract mathematical proofs for the first time. In this edition the player
talks to Lean in controlled English, using [Verbose Lean](https://github.com/PatrickMassot/verbose-lean4)
by Patrick Massot, instead of Lean's tactic names: `Assume h : P`, `We conclude by h`,
`Let's prove that x works`, `Let's construct it componentwise`, …

The levels and statements are identical to the original and are kept in sync automatically
(see [CONTRIBUTING.md](CONTRIBUTING.md)). Contributions are welcome through issues and pull
requests; the game can be played on the web without any of that.

## Playing locally

Follow lean4game's [running locally](https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md)
guide: clone `lean4game` next to this folder, run `lake build` here (`lake exe cache get` first
if Mathlib starts compiling), then `npm start` in `lean4game` and open
`http://localhost:3000/#/g/local/VerboseReintroductionToProofs`.

## Credits

Built on the [Lean Game Server](https://github.com/leanprover-community/lean4game) (ADAM,
Heinrich Heine University Düsseldorf) from the GameSkeleton template, and on Verbose Lean
(Apache-2.0); a few syntax definitions in `Game/Metadata/Tactic/` are copied from Verbose Lean,
see [LICENSE](LICENSE). The original game was created for a first-year seminar at Johns Hopkins
University in Fall 2025.
