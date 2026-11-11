#!/usr/bin/env python3
"""Replay every recorded player input in tests/replays through the game server's Runner.

usage: replay_all.py [GAME_DIR] [--dir tests/replays] [--worlds TypeWorld,FunctionWorld] [--difficulty 2]

File names encode the level: <letter><level>[variant].txt, where the letter stands for a world
(table below) and a trailing letter or `v1` marks an alternative solution of the same level.
Files starting with `H_` or containing `_help` are transcripts that end with `help`; they are not
pass/fail tests (the goal stays open) and are listed for manual inspection instead. Files
containing `_wrong` are inputs the game must reject; they pass when the Runner reports an error.

Runs one level at a time on purpose: parallel Lean processes overheat a laptop.
Needs a finished `lake build` (the Runner reads `.lake/gamedata`).
"""
import argparse, pathlib, re, subprocess, sys

WORLDS = {
    "T": "TypeWorld", "F": "FunctionWorld", "I": "ImplicationWorld", "P": "ProductWorld",
    "K": "ConjunctionWorld", "C": "CoproductWorld", "D": "DisjunctionWorld", "E": "EmptyWorld",
    "N": "NegationWorld", "L": "ClassicalWorld", "Q": "EqualityWorld", "B": "BooleanWorld",
    "U": "QuantifierWorld", "A": "AdvancedFunctionWorld", "V": "EquivalenceWorld",
    "M": "NaturalNumbersWorld", "W": "DependentWorld",
}

ap = argparse.ArgumentParser()
ap.add_argument("game_dir", nargs="?", default=".")
ap.add_argument("--dir", default="tests/replays")
ap.add_argument("--worlds", help="comma-separated world names to replay (default: all)")
ap.add_argument("--difficulty", type=int, default=2)
a = ap.parse_args()

game_dir = pathlib.Path(a.game_dir).resolve()
tests = (game_dir / a.dir) if not pathlib.Path(a.dir).is_absolute() else pathlib.Path(a.dir)
runner = pathlib.Path(__file__).resolve().parent / "run_level.py"
only = set(a.worlds.split(",")) if a.worlds else None

passed, failed, manual = [], [], []
for f in sorted(tests.glob("*.txt")):
    if f.name.startswith("H_") or "_help" in f.name:
        manual.append(f.name); continue
    m = re.match(r"([A-Z])(\d+)", f.name)
    if not m or m.group(1) not in WORLDS:
        print(f"skip {f.name}: no world letter"); continue
    world, level = WORLDS[m.group(1)], int(m.group(2))
    if only and world not in only:
        continue
    r = subprocess.run([sys.executable, str(runner), str(game_dir), world, str(level), str(f),
                        "--difficulty", str(a.difficulty)], capture_output=True, text=True)
    accepted = r.returncode == 0 and "proof accepted" in r.stdout
    expect_reject = "_wrong" in f.name
    ok = accepted != expect_reject
    (passed if ok else failed).append(f.name)
    print(f"{'PASS' if ok else 'FAIL'} {world} {level} ({f.name}){' [rejected as expected]' if ok and expect_reject else ''}")
    if not ok:
        print("    " + "\n    ".join((r.stdout + r.stderr).strip().splitlines()[:12]))

print(f"\n{len(passed)} passed, {len(failed)} failed, {len(manual)} help transcripts not checked"
      + (": " + ", ".join(manual) if manual else ""))
if failed:
    print("failed: " + ", ".join(failed))
sys.exit(1 if failed else 0)
