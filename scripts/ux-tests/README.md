# Browser playthrough harness

`playthrough.mjs` plays the game level by level in a real headless Chrome through a local
lean4game dev server, typing the recorded inputs from `tests/replays` into the typewriter exactly
as a player would, and checks per level: the typewriter appears, no "Crashed!" banner, every
sentence is accepted, "Level completed" shows, and Next is enabled. It writes `report.md`,
`progress.log` (appended as it goes, so an interrupted run keeps its results) and screenshots of
failures in `shots/`. At the end it reads the world map to check which worlds are locked.

Requirements: Node 18+, `npm install` in this folder (only `playwright-core`; no browser
download), Google Chrome at `/usr/bin/google-chrome` or `CHROME=/path/to/chrome`, and a running
dev server (`npm start` in a lean4game clone next to the game, see docs/handoff/maintenance.md).

    cd scripts/ux-tests && npm install
    node playthrough.mjs                                  # all 17 worlds, ~1 hour
    node playthrough.mjs TypeWorld,FunctionWorld          # some worlds
    node playthrough.mjs --from=ProductWorld:3 --to=ProductWorld:9
    BASE=https://adam.math.hhu.de GAME=emilyriehl/VerboseReintroductionToProofs node playthrough.mjs TypeWorld

Run it alone: together with `lake build` or `replay_all.py` it overheats a laptop.
`mapdump.mjs` prints the world-map SVG of the public game, useful when the client markup changes.
