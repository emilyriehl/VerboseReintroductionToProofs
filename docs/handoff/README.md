# Handoff: Reintroduction to Proofs, Verbose Lean edition

Written 2026-11-11 by the coding agent (Claude) that built this edition with Emily Riehl between
2026-10-25 and 2026-11-11, for whoever continues the work: a human maintainer or any coding
agent starting with no context. Everything here is plain Markdown and plain scripts; nothing
depends on a particular agent product. Emily's own instructions to agents are in
`working-with-emily.md` and summarised in the repository's `AGENTS.md`.

## Read in this order

1. **`overview.md`**: what the two games are, how they are linked, the toolchain, the layout of
   the code, the player's vocabulary and where each sentence is implemented, the design
   decisions and why.
2. **`maintenance.md`**: runbooks. Local setup, syncing with the original, regenerating
   `Game.pot`, replaying levels, publishing on adam, changing a level, reading build warnings,
   the client fork, bumping Lean, preparing PRs for the original, failure signatures.
3. **`roadmap.md`**: what is open: housekeeping, upstream contributions waiting to be opened
   (with the patches and drafts), the user-experience phase, content ideas, risks.
4. **`working-with-emily.md`**: her rules and preferences, what she has already decided.
5. `notes/`: the working documents of the port, verbatim, for the reasoning behind details:
   `PLAN_2026-10-25.md` (the original assessment and plan, with status notes),
   `SPIKE_FINDINGS.md` (feasibility spike and the first two UX rounds), `UX_NOTES.md` (Emily's
   playtest notes), `CONSTRUCTION_VOCABULARY.md` (design of the data-construction sentences),
   `PORT_NOTES.md` (every decision made while porting, chronological),
   `UPSTREAM_PR_SUGGESTIONS.md` (fixes found in the original and what became of them),
   `ANNOUNCEMENT_DRAFT.md` (the Zulip announcement and the list of upstream suggestions),
   `PR_DRAFT_verbose_gameExt.md` and `ISSUE_DRAFT_lean4game_scoped_syntax.md` (texts Emily can
   open upstream).
6. `lean4game-local-fixes.patch`: the nine commits of the lean4game client/relay fork used for
   local development (`git am` on lean4game tag v4.31.0); explained in `roadmap.md` §2.

## State of play on 2026-11-11

- **Both games are public on adam.math.hhu.de** and link to each other:
  <https://adam.math.hhu.de/#/g/emilyriehl/VerboseReintroductionToProofs> and
  <https://adam.math.hhu.de/#/g/emilyriehl/ReintroductionToProofs>. Last imports 2026-10-30.
  Not listed on adam's landing page (unlisted games need a request to the HHU team).
- **All 17 worlds, 159 levels, are ported and verified**: 253 recorded inputs pass the server's
  own `Runner` at difficulty 2; a headless-Chrome playthrough of every level through the real
  client passes; Emily played the whole game.
- **This repository's `main` is merged with the original's `main` at commit `9a2c07f`**
  (`UPSTREAM_COMMIT`), i.e. through the original's PR #50. Nothing is pending from upstream.
- **The weekly `sync-upstream` workflow currently cannot open pull requests** (repository
  setting; see `roadmap.md` §1). Since 2026-11-11 it opens an issue instead. Its two failed
  runs (2026-11-02, 2026-11-09) left a branch `sync/upstream-9a2c07f` on GitHub that is now
  obsolete (its content was merged by hand on 2026-11-11) and can be deleted.
- **Upstream contributions**: four PRs to the original are merged (#45, #46, #47, #50). Nothing
  has been opened at Verbose Lean or lean4game; the drafts and patches are in this folder and
  Emily opens them when she chooses.
- **Not backed up anywhere but Emily's laptop** (see "Where things are"): the lean4game clone
  with branch `local-fixes` (its patch is here), the separate PR clone of the original, the
  Verbose Lean checkout. All are reproducible from this folder.

## Where things are on Emily's machine (October 2026; paths may have moved)

| Path | What |
|---|---|
| `~/Math/Formalization/VerboseReintroductionToProofs` | this repository; `origin` = GitHub (ssh), `upstream` = the original |
| `~/Math/Formalization/ReintroductionToProofs` | Emily's working copy of the original, Lean v4.23.0. **Do not edit.** Its `.lake` is the quickest way to rebuild the original elsewhere (`maintenance.md` §2) |
| `~/Math/Formalization/verbose-game-spike/` | everything else from the project: `ReintroductionToProofs-prs` (clone for PR branches to the original), `lean4game` (dev server, branch `local-fixes`), `verbose-lean4` (Patrick's repo + `fork` remote = `emilyriehl/verbose-lean4`, branch `lean4game-compat`), `VerboseGameSpike` (the phase-0 spike project, superseded), `ux-tests` (original location of the browser harness), the notes copied into `notes/` |
| GitHub `emilyriehl/VerboseReintroductionToProofs` | public, MIT, Issues on; Actions: build-and-deploy, build-non-main, parity-check, sync-upstream |
| GitHub `emilyriehl/ReintroductionToProofs` | the original; PRs #45, #46, #47, #50 came from this project |
| GitHub `emilyriehl/verbose-lean4` | standalone copy of Verbose Lean; branch `lean4game-compat` = v4.31.0 + the `gameExt` rename; this game's lakefile depends on it |

## Thirty-second orientation for an agent

- You can build, test and push this repository on your own; read `AGENTS.md` for the rules.
- A change to the *mathematics* goes to the original first (PR, Emily approves), then syncs here.
- A change to *sentences, hints or phrase code* is made here: edit the level, keep every typed
  word in the inventory, update `Help.lean`'s table, add a replay file, `lake build`, replay,
  parity check, read the diff, push, tell Emily to re-import on adam.
- When something looks like a bug in the website rather than in the game, check
  `roadmap.md` §2 first: the known lean4game client problems and their patches are listed there.
