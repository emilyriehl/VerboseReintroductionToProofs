# Verbose Lean × lean4game: feasibility spike findings (2026-10-25)

Setup: Lean v4.31.0, lean4game v4.31.0 (`lean4game/`), Verbose Lean tag v4.31.0 with the
`gameExt` → `verboseConfigExt` rename on branch `lean4game-compat` (`verbose-lean4/`), and an
eight-level game `VerboseGameSpike/` built from GameSkeleton. Everything lives in this folder;
the original ReintroductionToProofs repo was not touched.

## Verdict: go

All eight levels (six propositional, two data-construction) build and are accepted by the game
server's `Runner` with inventory checking at the game's default difficulty. The one prototype
construction phrase (`Let's construct the pair`) works. Nothing found blocks the project; three
things need game-side code or upstream changes (below).

## What worked out of the box

| Level | Phrases | Result |
|---|---|---|
| 1 `P → P` | `Assume p : P`, `We conclude by p` | accepted (after fix 2 below) |
| 2 `P ∧ Q` | `Let's first prove that P`, `Let's now prove that Q` | accepted; the waiting goal displays as "You need to announce: Let's now prove that Q" |
| 3 `P ∨ Q → Q ∨ P` | `We proceed using h`, `Let's prove that P` | accepted |
| 4 `∃ b : Bool, …` | `Let's prove that false works`, `We conclude by rfl` | accepted |
| 5 induction on ℕ | `Let's prove by induction H : …`, `Fix k : ℕ`, `By even we get d such that hd : …`, `We conclude by hd` | accepted (incl. the `rw`-then-`rfl` closing step) |
| 6 `¬¬P → P` | `Assume for contradiction hp : ¬ P`, `We conclude by h applied to hp` | accepted |
| 7 data goal `B` | `We conclude by f a` | accepted |
| 8 data goal `A × B` | `Let's construct the pair` (game-defined), `We conclude by a` | accepted; stock `Let's first prove that A` fails with "This is not what needs to be proven." as predicted |

- `help` works in the player context and is genuinely useful: it names the applicable phrase
  with the statement filled in (e.g. "Let's prove that b₀ works: (b₀ && b₀) = (b₀ || b₀),
  replacing b₀ by an expression with type Bool"). For data goals it says "I have nothing to say
  about this goal." The suggestions are not clickable in lean4game (plain text).
- Verbose's error messages are good for beginners: "Given term P ⇒ P is not definitionally equal
  to the expected P", "This does not conclude.", "There is no assumption to introduce here."
- Inventory checking is word by word, exactly as predicted; declaring the leading words with
  `NewTactic` and the connective words with `NewHiddenTactic` (all in level 1) produced no
  "tactic not available" warnings at build time, and stock `intro`/`exact` are correctly refused
  for players ("The tactic 'intro' is not available in this game!").
- Build time is fine: Verbose compiles in a few minutes; the levels in seconds. Level start in
  the browser was not measured (see "Not tested").

## Three findings that need action

1. **`gameExt` clash** (known before the spike): confirmed; the one-line rename fixes it.
   Branch `lean4game-compat` + `PR_DRAFT_verbose_gameExt.md` are ready for Emily to commit/push.

2. **Scoped syntax never reaches the player.** Verbose's phrases that name a hypothesis
   (`Assume h : P`, `Assume for contradiction h : …`, `Fact h : … from …`,
   `Let's prove by induction H : …`) are `scoped` in `Verbose.Named`. lean4game's `Runner`
   command re-applies the level file's `open` declarations, but only inside its elaborator; the
   player's tactic block has already been parsed by then, so scoped *syntax* (and scoped
   notation, which is what math-atlas-lean ran into) is unavailable. Verified: `Assume p : P`
   fails with "expected 'for' or 'that'"; adding `open Verbose.Named` to the generated document
   header makes it parse.
   - Game-side fix (done and verified in the spike): `Game/Metadata/Tactic/NamedPhrases.lean`
     re-declares the Named phrases globally, delegating to Verbose's elaborators (about 25
     lines). Level files must not `open Verbose.Named` on top of that. After the fix, levels 1,
     3, 5 and 6 are accepted by the Runner with no `open` at all, and the nameless
     `Assume that P` still works alongside `Assume p : P` (no ambiguity).
   - Upstream fix worth proposing to lean4game: export the level's `openDecls` into the level
     JSON and have the relay emit `open …` lines in the document header before `Runner`. See
     `ISSUE_DRAFT_lean4game_scoped_syntax.md`.

3. **Verbose prints implications as `P ⇒ Q`.** `Verbose/Tactics/Notations.lean` installs a
   delaborator that shows `→` between propositions as `⇒` (and `help` messages say "The goal
   starts with “P ⇒ ...”"). Reintroduction to Proofs uses `→` for functions and implications on
   purpose. The spike restores `→` with a three-line delaborator override
   (`Game/Metadata/Tactic/Arrow.lean`, verified: the goal now prints as `⊢ P → P`); this is a
   pedagogical choice for Emily, either way works.

## Other observations

- `help` has a gap for the game's most common situation: with goal `P` and `p : P` in context it
  says "I have nothing to say about this goal" instead of suggesting `We conclude by p`.
  Verbose allows custom help providers (meta-programming); the game should add one for "the goal
  is one of your hypotheses" and one for data goals.

- `Assume that P` (nameless style) is global in Verbose and auto-names the hypothesis `hP`.
  With `help` available, a nameless-first game is a real option; the spike levels use names.
- `We conclude by h` also closes data goals; `Fix` only introduces data and `Assume` only
  hypotheses, which maps onto the game's elements/proofs theme.
- `Let's prove by induction H : stmt` needs the player to restate the whole statement, and the
  inductive step is presented reverted (`∀ k, P k → P (k+1)`), so `Fix k` / `Assume hk` follow.
- The inventory tiles are the leading words ("Assume", "We", "Let's", "Fix", "By", "help").
  Documentation per leading word has to list its phrases.
- `MakeGame` warned "No world introducing Bool.false / rfl": the terms used in `We conclude by
  rfl` and `Let's prove that false works` need `NewTheorem rfl` / `NewDefinition Bool.false`,
  as in the original game.
- Scripted replay: `scripts/run_level.py GAME_DIR World N proof.txt` reproduces exactly what
  the relay sends to the Lean server, so level solutions can be tested without a browser (and
  this could become a CI check in the real repo).

## Not tested (needs the browser)

- Typewriter-mode behaviour per phrase, hint display, level start time in the browser, the look
  of the inventory and the "You need to announce" goal. The built-in browser pane was hidden
  during the session and Monaco cannot initialise in a zero-size window; Emily's playtest at
  http://localhost:3000/#/g/local/VerboseGameSpike covers this (dev server runs in the
  "lean4game dev server" terminal tab; `UX_NOTES.md` is the template).

## Construction phrases still to design (for the real port)

Only one was prototyped. The data worlds need, at least: pairing / building a structure
(`Let's construct the pair` or similar; also for `Σ`, `≃`), injections into `⊕`
("Let's take the left summand"?), case analysis on `⊕`/`×`/`Bool`/`ℕ` with named components,
defining a function by cases (`match`), eliminating `Empty`, and `Set`-style local definitions
for data. All are small macros in the style of `Construct.lean`.

## Round 1 of UX testing (Emily, 2026-10-25) → changes made

Decisions: Verbose's `⇒` display is adopted (function types keep `→`, so the game shows the
elements/proofs distinction typographically for free); both `Assume p : P` and `Assume that P`
are available; upstream PR/issue drafts stay drafts until the end of the project.

Changes in the spike (all verified through the Runner):
- Every word of every Verbose English phrase is now declared (`NewHiddenTactic` in level 1, 59
  words), so `We rewrite using hm`, `We compute`, `Since …`, `Fact …`, `It suffices …` all pass
  the inventory check. The earlier "The tactic 'rewrite' is not available" was only a missing
  word, nothing to do with the original game's `rw`.
- `help` prints plain text (`Game/Metadata/Tactic/Help.lean`; Verbose's own `help` is disabled
  with `disableHelpTactic`). No more `malformed MsgEmbed`.
- New synonyms (`Game/Metadata/Tactic/Synonyms.lean`): `Let's use b` (= `We conclude by b`,
  intended for data goals) and `By h we get m such that k = 2 * m` with the fact auto-named `hm`.
- Docs rewritten for `Assume` (mentions `_`, `Assume that`, how to type `⇒ ¬ ∧ ∨ ∀ ∃ ℕ`), `We`
  (rewrite backwards with `← h`, `at h`, what `We compute` and `We apply` do), `Let's`, `By`,
  `Fix`, plus docs for `Since`, `Fact`/`Claim`, `Set`, `Calc`, `It`.
- Level 5: all hints after the first are hidden; the intro mentions `Assume hk : _`.
- `rfl` and `false` are now inventory items (Theorems / Definitions tabs are no longer empty).

New finding: **the word-by-word inventory leaks stock tactics.** Allowing the word `apply` for
`We apply h` also lets a player type `apply h`; same for `rewrite`, `unfold`, `rename`,
`induction`, `use`, `obtain`. Verified: `apply p` is accepted in level 1. Only matching by syntax
kind on the lean4game side fixes this properly (the issue draft already asks for that); until
then it is a known leak that beginners are unlikely to hit.

Known upstream problems seen in editor mode (not Verbose-specific): lean4game #453 "Repeated
spurious level completes in editor mode" (jumping to the next level, "no goals" after a partial
line), #549 "Previous and next buttons temporarily crash". Some of the crashes during round 1
may also have been caused by me rebuilding the game while it was being played (the Lean process
reads `.olean` files that the build replaces); round 2 should happen with no builds running.

Open design questions for Emily: trailing periods (see below), phrase naming for the data worlds,
whether to teach nameless phrases first.

Periods: Verbose phrases end at the end of the line because they are Lean tactics; a trailing
`.` would be read by Lean as the start of a projection (`p.1`) or a namespace, so Verbose does not
allow it. If periods matter for the reading experience, the cleanest place to add them is the
client: strip a final `.` from each typewriter line before sending it (a Phase 4 item).

## Observation during round 2 (2026-10-25 13:15): RPC reconnect storm

The relay log shows the client sending `$/lean/rpc/connect` for the (already closed) level
document in a tight loop, each answered by Lean with error -32801 "Cannot process request to
closed file …/Game/Metadata.lean"; request ids had passed 26,000 within the session. The
infoview keeps trying to reopen an RPC session after the document was closed (level switch or
mode switch). Closing the app's own hidden browser tab did not stop it, so it comes from the player's tab.
By request-id arithmetic (about 170 requests/s) it started around 13:12:50, two minutes
before any client file was edited, so it was not caused by a hot reload; a level or mode switch
in the player's tab is the likely trigger. It is a lean4game client issue and a
plausible cause of the "flashing" and sluggishness seen in round 1; a page reload clears it. To investigate in the client fork:
stop reconnecting when the server reports the file closed (vscode-lean4 `rpcSessions` handling
in lean4game's infoview), or make sure the old editor connection is disposed on level change.

## Round 2 of UX testing (Emily, 2026-10-25 15:05) → changes made

Game side (`Game/Metadata/Tactic/Overrides.lean`, high-priority re-declarations that delegate to
Verbose's elaborators):
- `Assume that _` names the assumption after the hypothesis it finds (`hPQ`), not `h`/`h_1`.
- `Let's prove by induction that _` and `Let's prove by induction H : _` take the statement from
  the goal (Emily's suggestion for level 5).
- `We proceed using s` also works for `s : A ⊕ B` (one goal per summand, then `Fix a : A`), the
  data counterpart of `h : P ∨ Q`.
- `We conclude by h` adds guidance when `h` is a disjunction/sum ("write `We proceed using h`"),
  a conjunction/pair/existential ("write `By h we get …`"), or an implication/function whose
  conclusion is the goal ("write `We apply h`").
- `Assume for contradiction that ¬ P` already worked (Verbose's nameless form is global).

Client side (lean4game clone, branch `local-fixes`, two commits):
- Completion validation (adapted from upstream PR #455) now also covers the editor-mode
  infoview, which has its own `Game.getProofState` call site (`info.tsx`); round 2's "jumped to
  level 5 while typing the first line" happened through that unpatched path.
- The reconnect storm's cause: the infoview retried every `ContentModified` error immediately,
  and a closed document (after a level or mode switch) answers every request with that error.
  Requests for a closed file are no longer retried.
- Still open for the client fork: debounce editor-mode updates (Emily: "wait until I finish
  typing"), period stripping in editor mode, clickable `help` suggestions.
