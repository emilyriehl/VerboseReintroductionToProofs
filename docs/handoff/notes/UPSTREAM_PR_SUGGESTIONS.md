# Suggested PRs to emilyriehl/ReintroductionToProofs

Prepared 2026-10-26 while porting the game to Verbose Lean. **Outcome:** items 1–7 went upstream as one PR (#45, merged); its item-7 commit was wrong (levels 4 and 6 of Quantifier World swapped) and was repaired by #46 (merged). Item 8 was declined (Emily keeps the unused file). Both upstream merges are synced into the Verbose edition (commits 783da34, 93ba9b3). Each suggestion is one branch with
one commit in the separate clone `~/Math/Formalization/verbose-game-spike/ReintroductionToProofs-prs`
(your working copy in `~/Math/Formalization/ReintroductionToProofs` was not touched). Nothing has
been pushed to GitHub.

## How to review and open them yourself

From your working copy:

```bash
cd ~/Math/Formalization/ReintroductionToProofs
git fetch ../verbose-game-spike/ReintroductionToProofs-prs 'refs/heads/fix/*:refs/heads/fix/*' 'refs/heads/chore/*:refs/heads/chore/*'
git log --oneline main..fix/typos        # one commit per branch
git diff main..fix/typos                 # review
git push origin fix/typos                # then open the PR on GitHub, or:
gh pr create --head fix/typos --fill
```

Or say the word and I push the branches and open the PRs (one per item, each reviewable and
closable on its own).

Each edited level file was compiled against your existing local build (`lake env lean` from your
repo, reading only its `.lake` artifacts); results are in the table. Items 1–6 change only prose or
docstrings. Item 7 changes inventory declarations and deserves a full `lake build` to confirm
`MakeGame` is happy. Item 8 deletes a file.

| # | Branch | Change | Risk |
|---|---|---|---|
| 1 | `fix/or-doc-disjunction` | BooleanWorld L05: both docstrings for `Bool.or` said "conjunction" | none (docs) |
| 2 | `fix/not-injective-doc` | AdvancedFunctionWorld L05: `TheoremDoc not_injective` said "is surjective" | none (docs) |
| 3 | `fix/choose-spec-hint` | AdvancedFunctionWorld L12: hint said `apply (surj f {x}).choose_spec`; the sample proof uses `(surj (f x))`. Also "now you are now" | none (hint text) |
| 4 | `fix/of-comp-hint` | AdvancedFunctionWorld L07: hint said "the hypothesis that `g` is injective"; it is `g ∘ f` | none (hint text) |
| 5 | `fix/boss-level-reference` | NaturalNumbersWorld L11 intro pointed to `¬ (true = false)`; Boolean L08 proves `¬ (false = true)` | none (prose) |
| 6 | `fix/typos` | "principal" → "principle", "these hypothesis" → "hypotheses" (NN L03), "two similar hypothesis" (AdvFn L06), "skils", "argument in sound" (Game.lean) | none (prose) |
| 7 | `fix/duplicate-use-tactic` | `TacticDoc use` + `NewTactic use` were declared in both Quantifier L04 and L06; keep one in L04 with the longer L06 text | low; rebuild to check MakeGame |
| 8 | `chore/remove-unused-level` | delete `EquivalenceWorld/L08_UnusedBossLevel.lean` (not imported; same title as L07) | none |

## Things I checked and do *not* suggest changing

- `rw [zero_add]` (NN L09) and `.symm` (AdvancedFunction L16): in the Verbose edition these words
  also resolve to Mathlib's root `zero_add`/`symm` and get rejected by the inventory check. In your
  game's environment neither root name exists (checked with `resolveGlobalConst` against your
  build), so players are not affected. No change needed upstream.
- `rw [pred_comp_succ]` (NN L10): the v4.23 game server restores the level's scope
  (`namespace ReintroductionToProofs` + `open Nat`) for player input (`Runner.lean:112–118`), so
  the short name should work on adam. The v4.31 server behaves differently; that is a lean4game
  matter, noted for the upstream-drafts phase. If you want to be sure, type `rw [pred_comp_succ]`
  in L10 on adam.
- `NewDefinition False` sits in BooleanWorld L08 although `False` is discussed from Negation World
  on. Players of the original never type the word `False`, so it is harmless there (the Verbose
  edition moved it because `Assume p : False` does type it).

## Optional, larger (not prepared; say if you want them)

- **Bump to Lean v4.31.0** (toolchain, lakefile per lean4game #518, GameServer/Mathlib/i18n tags).
  The original's custom tactics compiled unchanged at v4.31 inside the Verbose repo, so this is
  mostly mechanical, but it needs a full build and a playtest on adam. Benefit: same version as the
  Verbose edition, newer GameServer fixes.
- **README/CONTRIBUTING**: a pointer to the Verbose edition once it is public, and a writing
  convention (tactic-specific sentences in their own paragraph at the end of an Introduction or
  Hint) that keeps the weekly sync merges conflict-free.
