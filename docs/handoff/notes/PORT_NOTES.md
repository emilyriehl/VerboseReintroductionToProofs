# Notes for the real port (decisions and placements collected during the spike)

## `We compute`

What it does (Verbose `computeTac`): tries `ring_nf`, then `norm_num`, then `abel_nf`, then
`dsimp only`, on the goal (or `at h`). Verified in the spike environment:

| Statement from the original game | `We compute` |
|---|---|
| `1 = succ 0`, `4 = succ 3`, `9223372036854775809 = succ 9223372036854775808` (NaturalNumbersWorld L01) | closes |
| `2 + 2 = 4`, `1 + 5 = 2 * 3`, `12 + 23 = 5 * (4 + 3)`, `(3 + 1) + 2 = 2 + (1 + 3)` (L02) | closes |
| `pred (succ n) = n` (L05) | closes |
| `n + 0 = n` (L07), **`0 + n = n` (L07), `n + m = m + n` (L09)** | closes |
| `(false && false) = (false || false)` (QuantifierWorld L04), `f true = false` after unfolding a `match`-defined `f` (BooleanWorld) | closes |
| `P` from `p : P` | fails with "The goal P does not seem to follow from a computation without using a local assumption." |

Placement: introduce it in **NaturalNumbersWorld L02 "Normal Forms"**, whose introduction is
already about both sides reducing to a normal form; L01 "Numerals" keeps `We conclude by rfl`
("holds by definition"). Everything before NaturalNumbersWorld keeps using `We conclude by rfl`.

Hazard: `We compute` proves `0 + n = n`, `succ_add` and `n + m = m + n`, i.e. exactly the
induction exercises of L07–L09 (and probably L10). Those levels must carry
`DisabledTactic «compute»` (the word-based inventory makes that possible), mirroring the
original's `DisabledTheorem Nat.zero_add …`.

Draft `TacticDoc «compute»` text (to attach to the `We` tile and to level L02):

> `We compute` asks Lean to compute both sides of an equation and compare the results. It
> normalises arithmetic expressions (`2 + 2` becomes `4`, `2 * (m + 1)` becomes `2 * m + 2`),
> so it proves equations between numerals and equations that hold by rearranging sums and
> products. `We compute at h` does the same inside a hypothesis `h`. It does not use your
> assumptions: an equation that depends on a hypothesis `h : k = 2 * m` needs
> `We rewrite using h` first.

## Periods at the end of phrases

Decision (Emily): players may type a period at the end of a phrase; the game removes it.
- Typewriter mode: strip a trailing `.` from the line before it is inserted into the proof
  (client, `typewriter.tsx`, `runCommand`). Done in the local lean4game clone (branch
  `local-fixes`).
- Editor mode: not yet. Incremental document sync makes a naive relay-side replacement unsound
  (`h.1` typed character by character passes through a state where `.` ends the line). A sound
  version keeps a mirror of the document in the relay and sends full-text changes with
  end-of-line periods blanked. Phase 4 item.
- Where to explain it: ProductWorld L01 "Pairing", next to the remark that spacing around
  `⟨a, b⟩` does not matter: "You may end a phrase with a period, as in a sentence; the game
  removes it before Lean reads the line, because Lean would read `p.` as the start of `p.1`."
- Both changes live in the lean4game *client/relay*, so players only get them on a server
  running this fork (or after the changes are upstreamed). adam.math.hhu.de runs the stock
  client.

## Repository name

`VerboseReintroductionToProofs` under github.com/emilyriehl (confirmed).

## Phrase decisions so far

- Implications display as `P ⇒ Q` (Verbose default); function types stay `A → B`.
- Both `Assume p : P` and `Assume that P` are available; `_` may replace a restated statement.
- `Let's use b` is the data-goal synonym of `We conclude by b`.
- `By h we get m such that k = 2 * m` auto-names the fact (`hm`).
- `help` prints plain text.
- `Let's construct the pair` is the only construction phrase so far; the rest of the data
  vocabulary (sums, case analysis on data, functions by cases, `Empty`) is still to design.

## Client fork status (lean4game clone, branch `local-fixes`)

1. Typewriter strips trailing periods.
2. Level completion validated against the goal state in both the typewriter and the editor-mode
   paths (upstream issues #402/#453).
3. No retry loop on requests for a closed document.

Not done: editor-mode debounce, editor-mode period handling (needs a document mirror in the
relay), clickable `help` suggestions, per-phrase inventory tiles. These need a server running
this client (self-hosting) or upstreaming; adam.math.hhu.de runs the stock client.

## Decisions 2026-10-26

- License: MIT, as the original (LICENSE with Jon Eugster 2023 for the template and Emily's own
  line); README credits Verbose Lean (Apache-2.0) for the copied syntax definitions.
- Hosting: adam.math.hhu.de as an unlisted game needs no contact (import trigger URL after the
  GitHub Action); a landing-page tile would need a request to Jon Eugster. GitHub Pages cannot
  host the game (server-side Lean).
- The real repo's lakefile must reference the Verbose fork on GitHub
  (`emilyriehl/verbose-lean4`, branch `lean4game-compat`): a fork and a branch, no PR yet.
- Construction vocabulary: see CONSTRUCTION_VOCABULARY.md, "Decisions" section.

## Consequences of Verbose's reserved words for the port (found 2026-10-26)

- `and`, `or` (and `to`, `is`, `on`, `as`, `for`, `we`, `by`, `the`, `it`, `that`, `such`, …) are
  keyword tokens once Verbose is imported. In Lean code the Boolean functions must be written
  `Bool.and x y` / `Bool.or x y` or with the notations `x && y` / `x || y`; the BooleanWorld
  prose, which currently teaches `and x y`, should switch to `x && y` and `x || y` (and the
  DefinitionDocs should say so). Players cannot type bare `and`/`or` as identifiers.
- `apply`, `induction`, `cases`, `use`, `compute`, `rewrite`, … must be written `«apply»` in
  `TacticDoc`/`NewTactic` lines (the stock tactics themselves still parse).
- Mathlib's root-level `em` makes bare `em` ambiguous under `open Classical`; the port uses
  `We discuss depending on whether P or ¬ P`, so this only matters for the unported levels.
- `zero_add` / `symm` inventory warnings: with Mathlib in scope these short names resolve to the
  general lemmas, not `Nat.zero_add` / `Eq.symm`; the ported NaturalNumbersWorld and
  EqualityWorld should refer to the `Nat.`/`Eq.` names explicitly.

## Decisions while porting the last worlds (2026-10-26, evening)

- `We rewrite using h` no longer tries `rfl` afterwards (override `gameRewrite` in
  `Game/Metadata/Tactic/Overrides.lean`). Verbose closes `a = a` only when
  `with_reducible rfl` succeeds, which depends on transparency details players cannot see; the
  original game's `rw` behaves like `rewrite` for the same reason. Every rewrite is now followed
  by an explicit `We conclude by rfl`, as in the original proofs.
- `We compute` splits conjunctions first (override `gameCompute`), so NaturalNumbersWorld L02
  is solved by `We compute` alone. Introduced in L02 with a `TacticDoc «compute»`;
  `DisabledTactic «compute»` in L07–L10.
- `This is impossible because of p` also closes goals from an impossible equation such as
  `p : false = true` (`cases p` / `nomatch p` fallbacks), used in AdvancedFunctionWorld L05.
- The inventory entry `NewDefinition False` moved from BooleanWorld L08 to NegationWorld L01:
  `Assume p : False` types the word `False`, and the word-based inventory otherwise reports a
  dependency loop NegationWorld → BooleanWorld.
- Function extensionality: `By funext it suffices to prove that ∀ x : A, f x = g x`
  (Verbose's own phrase); `funext` is a `NewTheorem` in AdvancedFunctionWorld L13, replacing
  the `ext` tactic tile.
- Existential whose witness is a function: `Set f : ℕ → ℕ := fun n ↦ …` then
  `Let's prove that f works` (AdvancedFunctionWorld L12, NaturalNumbersWorld L04); the
  alternative `Let's construct the pair` + `Fix n` + `Let's define it by recursion on n`
  (with `Fix r : ℕ` for the recursive value) also works and is mentioned in L04.
- `Let's first prove that _` and `Let's now prove that _` are accepted by Verbose (the hole
  unifies with the conjunct); useful when the goal is long. Not advertised in the text yet.
- Case analysis on a hypothesis `hk : P ∨ Q` inside an induction step: `We proceed using hk`
  then `Assume even : P` (spike version kept for NaturalNumbersWorld L03).
- Found while replaying: inside the game Runner, `open Nat` does not open
  `ReintroductionToProofs.Nat`, so players cannot write `pred_comp_succ` (NaturalNumbersWorld
  L10); the port writes `Nat.pred_comp_succ`. The original game likely has the same problem on
  adam (its sample proof uses `rw [pred_comp_succ]`); worth checking there and telling Emily.
- Inventory name clashes found by the full replay (likely also present in the original game on
  adam, worth checking there): in NaturalNumbersWorld L09 the word `zero_add` resolves both to
  `Nat.zero_add` (in the inventory) and to Mathlib's root `zero_add` (not in it), so
  `rw [zero_add]` is rejected at difficulty 2; the port writes `Nat.zero_add`. Likewise `.symm`
  in `(congrFun p₀ a₀).symm` (AdvancedFunctionWorld L16) resolves to Mathlib's root `symm`;
  the port writes `Eq.symm (…)`. These are the two "No world introducing zero_add / symm"
  warnings `MakeGame` prints for the original.
- A `NewHiddenTactic` word still needs a `TacticDoc`: without a doc entry it never reaches the
  inventory list and the Runner rejects it (seen with `match` in BooleanWorld L01).

## Client fixes found during Emily's full playthrough (2026-10-26, evening; branch `local-fixes`)

- **World unlock bug in lean4game itself** (`client/src/store/world-tree-atoms.ts`,
  `worldDependenciesCompletedAtomFamily`): for each edge `A → W` it checked whether `W` (not `A`)
  was completed, so at difficulty 2 ("regular") no world after the first could ever unlock; at
  "relaxed" the map ignores locks, which is why switching difficulty "fixed" it. Still present on
  lean4game `main` (commit 9f0aadc, v4.35 bump), so adam is affected too. Fixed locally
  (`it[0]`); candidate for the lean4game drafts Emily opens at the end.
- "Crashed!" banner flashing on every level change: requests in flight when the previous level's
  document is closed come back with "file worker … has been terminated" / cancelled; the
  typewriter's goal loader treated any failure as a crash. Now ignored like a missing connection.
- The client logs a one-line JSON summary of every proof state it receives
  (`proof state summary: …`), handy for debugging completion flags.
- Reminder: the relay opens every level under the same document URI (`Game/Metadata.lean`), so a
  level switch always restarts the Lean file worker.

## Decisions from Emily's playthrough (2026-10-26, night)

- `Claim h : P from e` is the game's sentence for intermediate facts (Verbose's `Fact` is not
  offered; `We know` was considered and dropped). The nameless `Claim P from e` / `Claim P by …`
  names the fact automatically (game addition, `Synonyms.lean`). `Claim` is the tile introduced
  in ImplicationWorld L04.
- `help` is level-aware (`Game/Metadata/Tactic/Help.lean`): the current level is read off the
  imported module `Game.Levels.<World>.L<nn>_…`, the world graph from `.lake/gamedata/game.json`,
  and a table `taughtAt` says where each sentence is introduced; suggestions from later levels are
  dropped with a one-line note. Sentences the game never teaches (`Since …`, `We combine`) are
  never suggested.
- `Prop` is declared as a word (like `Type`, `Sort`), because the server treats every alphabetic
  word as a tactic word and the dev client sends no unlocked-item list.
- FunctionWorld L07 mentions the untyped `Fix f b a`.

## Browser playthrough harness and the "Level not found" bug (2026-10-27)

- `verbose-game-spike/ux-tests/playthrough.mjs` drives the real client in headless system
  Chrome (playwright-core, no browser download) through the dev server: for each level it types
  the recorded `.lake/runner-tests` input into the typewriter and checks typewriter present, no
  "Crashed!" banner, every sentence accepted, "Level completed", Next enabled. `report.md`,
  `progress.log` (incremental), screenshots of failures in `shots/`. Options: world list,
  `--from=World:n`, `--to=World:n`, env `DEBUG=1` (client log lines), `SHOTS=1`.
- Root cause of the persistent "Crashed! … Level not found" after crossing into a new world
  (Emily saw it on Function World 1): lean4game names level documents
  `file:///<world>/<level>.lean`; vscode-lean4 keeps one Lean client per folder, so a world
  change opened a second server connection while the infoview's RPC session stayed on the first
  (whose worker still held the previous level), and `Game.getProofState` answered "Level not
  found" (server trace "no world id") until a page reload. Fix on branch `local-fixes`
  (commit 459c126): all levels live in `file:///levels/<world>__<level>.lean`; the relay parses
  and maps back accordingly. Also (cdf6054) the relay sends a `didClose` for the previous document
  before a new `didOpen` on the same connection. Both are candidates for upstream lean4game.
