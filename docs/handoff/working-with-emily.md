# Working with Emily

Emily Riehl (GitHub `emilyriehl`, Johns Hopkins) owns both games and makes every decision about
wording, pedagogy and what goes upstream. She is an expert mathematician and a fluent Lean user,
new to lean4game internals and to Verbose Lean. These are the rules and preferences she stated
during the project (October 2026); treat them as standing instructions until she changes them.

## Repositories and permissions

| Place | What an agent may do |
|---|---|
| `emilyriehl/VerboseReintroductionToProofs` (this repo) | commit and push (she has pushed to `main` directly through an agent many times); open PRs for anything she should review |
| `emilyriehl/ReintroductionToProofs` (the original game) | **never edit her working copy** `~/Math/Formalization/ReintroductionToProofs` (she asked explicitly, and the rule was never lifted); prepare branches in the separate clone `~/Math/Formalization/verbose-game-spike/ReintroductionToProofs-prs` (origin = her repo over ssh); push a branch and open a PR only after she has approved the content, and show her the wording of anything player-facing first |
| `emilyriehl/verbose-lean4` (her copy of Verbose Lean, branch `lean4game-compat`) | pushing was allowed once ("It may be okay to push also my verbose fork"); ask before pushing anything new |
| `PatrickMassot/verbose-lean4`, `leanprover-community/lean4game` | **never push, never open issues or PRs.** Draft the patch and the text; she opens them. All drafts were held until the project settles (her choice) |
| adam.math.hhu.de | she triggers imports herself; give her the trigger URL and the status |
| Zulip, announcements | she posts; drafts should be brief ("better brief than verbose") |

## Verification before anything is pushed

Read the whole diff of every generated commit before pushing to any repository of hers. An
early PR (#45 of the original) swapped two level statements through a sloppy regex, compiled
fine, and had to be repaired by a second PR. Compile checks do not catch swapped or dropped
text; reading does. For prose edits prefer line-level replacements with exact anchors (assert
that the anchor occurs exactly once) over character-level or regex edits.

## Her computer

- Never run `lake build` of this game while she is playing the local dev server: it swaps the
  compiled files under her session and every level crashes. Batch text edits and rebuild when
  she says she has stopped.
- Run heavy jobs one at a time. Two Lean builds plus a browser playthrough overheated the
  laptop; she asked for serial work ("it's okay to work serially rather than in parallel").
- Kill processes by pid, not by pattern (`pkill -f` once killed the agent's own shell).
- The dev server (`npm start` in the lean4game clone) sometimes leaves a relay on port 8080
  behind; kill that pid before restarting.

## How she likes to be talked to

- Outcome first, short, concrete. Ask for a decision with two or three worked examples of what
  the player would type, not with an abstract option list (that is how `Claim` was chosen).
- When she asks a question ("is this fixed now?", "why do I get this error?"), answer it;
  do not start a new fix until she asks for one.
- When she asks for an explanation and says she does not understand a paragraph, rewrite it
  plainly; do not add more detail.
- She plays the game herself and reports UX problems in the order she meets them; those
  reports are the most valuable testing the project gets. Reproduce them with the browser
  harness before changing code.
- Public-facing text (announcement, PR descriptions, level prose) is approved by her before it
  goes anywhere.

## Decisions she has already made (do not reopen)

- The second edition is a separate public repository with shared git history and merge-based
  syncing, hosted on adam like the original. Lean v4.31.0 (the newest version lean4game,
  Verbose, Mathlib and lean-i18n all tag).
- The data worlds are ported with purpose-built construction sentences rather than dropped.
- The fact sentence is `Claim h : P from e` (also nameless `Claim P from e`); Verbose's `Fact`
  and the considered `We know` are not offered.
- Implications display as `P ⇒ Q` (Verbose's default); function types stay `A → B`.
- Players may end a sentence with a period (stripped by the client fork; not on adam).
- `Unit`'s canonical element is written `()`; `⟨⟩` is mentioned as also working and `\<>` is
  taught at that level; `\<` and `\>` are taught at pairs.
- In the original she kept the unused Equivalence World boss level file, and she prefers the
  phrase "information of whether an element" over "information on whether".
- Both edits of a reader's prose suggestions were applied except the ones about Booleans and
  the phrase above; see `notes/UPSTREAM_PR_SUGGESTIONS.md` and PR #47 of the original.

## Attribution

Commits written by an agent end with a `Co-Authored-By: <agent name> <email>` trailer and pull
request descriptions end with a line saying they were generated with that agent. Commits for
PRs to Patrick Massot's or the lean4game repositories are hers (she commits and opens them), so
attribution there is her decision.
