# Draft for the upstream PR to PatrickMassot/verbose-lean4 (you commit and open it)

Branch: `lean4game-compat` in ~/Math/Formalization/verbose-game-spike/verbose-lean4
(based on tag v4.31.0 = current master). The change is staged but not committed.

## Suggested commit message

    Rename the configuration env extension to avoid a clash with lean4game

    lean4game's GameServer registers a persistent environment extension named
    `gameExt`. Verbose registered its configuration extension under the same
    name, so a Lean project importing both failed with
    `invalid environment extension, 'gameExt' has already been used`.
    The name is internal to Verbose (only used through
    `verboseConfigurationExt`), so renaming it to `verboseConfigExt` has no
    user-visible effect.

## Suggested PR description

Title: Rename internal env extension `gameExt` → `verboseConfigExt` (lean4game compatibility)

I'm building a lean4game (https://github.com/leanprover-community/lean4game) whose levels are
written with Verbose Lean. lean4game's `GameServer` package registers a persistent environment
extension called `gameExt`, and `Verbose/Infrastructure/Extension.lean` registers its
configuration extension under the same name, so importing both fails:

    invalid environment extension, 'gameExt' has already been used

This one-line change renames Verbose's extension to `verboseConfigExt`. The name only appears
in the `registerSingleValPersistentEnvExtension` call; everything else goes through
`verboseConfigurationExt`, so nothing changes for users. (The only other lean4game + Verbose
project I know of, https://github.com/Chr0mium24/math-atlas-lean, vendored a patched copy of
Verbose for exactly this reason; see its vendor/verbose/NOTICE.md.)

## Commands for you

    cd ~/Math/Formalization/verbose-game-spike/verbose-lean4
    git commit            # message above
    # after creating your fork emilyriehl/verbose-lean4 on GitHub:
    git remote add fork git@github.com:emilyriehl/verbose-lean4.git
    git push -u fork lean4game-compat
    # then open the PR on GitHub from emilyriehl:lean4game-compat to PatrickMassot:master
