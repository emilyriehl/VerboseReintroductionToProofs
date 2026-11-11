# Open work and ideas (as of 2026-11-11)

Everything below is optional; the game is complete and public. Items are grouped by where the
work lands. "Draft ready" means a text or patch exists in this folder and only needs Emily's
review and her hand on the Open/Push button.

## 1. Housekeeping in this repository

- **Sync workflow pull requests: resolved 2026-11-11.** The weekly `sync-upstream` workflow had
  failed at `gh pr create` because the repository setting *Settings → Actions → General → Allow
  GitHub Actions to create and approve pull requests* was off; Emily enabled it on 2026-11-11.
  The workflow also falls back to opening an issue should PR creation ever fail again.
- **Back up the lean4game client fixes.** The branch `local-fixes` of the lean4game clone
  exists only on Emily's laptop. `lean4game-local-fixes.patch` in this folder is a copy
  (`git am`-able on tag v4.31.0). A fork `emilyriehl/lean4game` would be the natural home;
  creating it needs her approval.
- **Retire dead files.** `Game/Metadata/Tactic/{Rw,Use,Induction,Constructor}.lean` are the
  original game's custom tactics, kept only so that upstream merges touching them stay
  conflict-free; they are not imported. `sofi.sh` is a stray script inherited from the template.
  (Obsolete remote branches were deleted by Emily on 2026-11-11; agent tooling cannot delete
  remote branches, so leave that to her.)
- **Original's documentation**: a line in the original's README pointing to this edition and a
  writing convention (tactic-specific sentences in their own paragraph at the end of an
  Introduction or Hint) would keep the weekly merges conflict-free. Suggested in
  `notes/UPSTREAM_PR_SUGGESTIONS.md`, never done.
- **Landing-page listing on adam.** Both games are "unlisted" (reachable by URL, imported
  through the public trigger). A tile on the adam landing page needs a request to Jon Eugster
  (HHU). Emily's call.

## 2. Upstream contributions waiting for Emily to open

### PatrickMassot/verbose-lean4

- **Rename the `gameExt` environment extension** (one line in
  `Verbose/Infrastructure/Extension.lean`). Without it Verbose and lean4game's GameServer cannot
  be imported together. The commit exists on branch `lean4game-compat` of
  `emilyriehl/verbose-lean4` (rev e3a22562, on top of tag v4.31.0) and this game's lakefile
  depends on that branch. PR text: `notes/PR_DRAFT_verbose_gameExt.md`. Once merged and tagged,
  switch `lakefile.lean` back to Patrick's repository.
- Later, if there is interest: the construction sentences for data goals (`Let's construct it
  componentwise`, `Let's construct an element of A`, `Let's consider the case where …`,
  `This is impossible because of e`, nameless `Claim`), with French versions and
  `implement_endpoint` messages. Design notes: `notes/CONSTRUCTION_VOCABULARY.md`.

### leanprover-community/lean4game

All of these were still present on lean4game `main` at the v4.35 bump (commit 9f0aadc); adam's
deployed client is an older generation and does not show the first two. Patches for the first
three are in `lean4game-local-fixes.patch`; drafts for the others are texts only.

1. **World unlock checks the wrong world** (`client/src/store/world-tree-atoms.ts`,
   `worldDependenciesCompletedAtomFamily` tests `worldId` instead of the edge source `it[0]`).
   At "regular" difficulty no world after the first can be entered. Patch: commit 7d9fc0a.
2. **Per-world document folders break world changes.** Levels are opened as
   `file:///<World>/<n>.lean`; vscode-lean4 keeps one Lean client per folder, so crossing into a
   new world opens a second connection while the infoview's RPC session stays on the first, and
   every proof-state request answers "Level not found" ("Crashed!" banner) until a reload.
   Patch: one folder `file:///levels/<world>__<level>.lean` plus relay mapping (commit 459c126),
   and the relay sending `didClose` before a new `didOpen` on the same connection (cdf6054).
3. **Spurious "level completed" in editor mode** (issues #402/#453): completion should be checked
   against the goal state in the infoview path too. Patch: commit 7790387 (adapted from PR #455).
4. **Dev client sends no `difficulty`/`inventory`** in `initializationOptions`, so the relay
   falls back to difficulty 1 and an empty inventory in local development. Text only.
5. **Scoped syntax never reaches players.** The Runner applies the level's `open` declarations
   after parsing the player's input, so Verbose's `scoped` named phrases had to be re-declared
   globally in this game (`NamedPhrases.lean`). Draft: `notes/ISSUE_DRAFT_lean4game_scoped_syntax.md`.
6. **Inventory matched word by word.** Multi-word sentences need one hidden "tactic" per word,
   each with a doc entry; matching by syntax kind (or allowing multi-word `TacticDoc` names)
   would give one tile per sentence. Text only; see "Inventory" in `overview.md`.
7. Minor: the typewriter strips a trailing period (commit 9fadcf2, Emily's preference); the
   "Crashed!" banner should not appear for a closed-document race on level change (adb1ba3,
   f37a748, 18b8e85, 00595d2).

### emilyriehl/ReintroductionToProofs (the original)

- Optional bump to Lean v4.31.0 so both games share a toolchain. The original's custom tactics
  compiled unchanged at v4.31 inside this repository, so it is mostly mechanical (toolchain,
  lakefile per lean4game #518, GameServer/Mathlib/i18n tags), but it needs a full build and a
  playtest on adam.

## 3. User-experience phase (needs a server running the client fork, or upstreaming)

The plan's "phase 4". adam runs the stock client, so these only reach players after upstreaming
or on a self-hosted instance (`doc/hosting.md` in lean4game: Linux box, nginx, node/pm2,
bubblewrap, elan).

- Render `help`'s suggestions as clickable chips above the typewriter and run `help`
  automatically after each step: the cheapest approximation of Verbose's point-and-click panel
  (lean4game issue #277 asks for this).
- One inventory tile per sentence instead of per leading word (`We`, `Let's`, `By`, …).
- Editor-mode period stripping (needs a document mirror in the relay; see `notes/PORT_NOTES.md`,
  "Periods").
- Mobile layout, progress model, replacing Monaco: only after the above.
- Before/after playtest on two worlds with people from the target audience.

## 4. Content ideas noted during the port

- Wording for the recursive value in `Let's define it by recursion on n` (currently `Fix r : C k`
  in the `succ k` case; "with the value for k called r" was floated).
- `The case e : Empty cannot occur` as a synonym of `This is impossible because of e`.
- `Let's first prove that _` / `Let's now prove that _` (hole instead of restating a long
  conjunct) works but is not advertised in any level text.
- Conclusions could point out the parallel the game is about: `Fix` and `Assume` change the
  goal in the same way, `Let's use` and `We conclude by` are the same sentence for data and
  proofs.
- The Boolean World prose still teaches `and x y`/`or x y` in places where this edition must
  write `x && y`/`x || y` (Verbose reserves `and`/`or`); the four statements that differ are
  allow-listed in `parity-allowlist.txt`.

## 5. Risks to watch

- **adam upgrades its client.** The day adam deploys a lean4game client generation with the
  world-unlock bug (item 1 above), both games stop unlocking worlds at "regular" difficulty.
  The browser harness run against adam (`BASE=https://adam.math.hhu.de GAME=emilyriehl/…`)
  detects it through the world-map check.
- **Version drift.** Verbose Lean tags lag lean4game; a Lean bump is only possible to a version
  all four of lean4game, Verbose, Mathlib and lean-i18n tag. Recipe in `maintenance.md`.
- **Prose merges.** Every upstream prose edit in a sentence that also mentions a tactic
  conflicts here and must be re-worded by hand; the sync workflow flags these.
