#!/usr/bin/env python3
"""Replay a player's proof through lean4game's Runner exactly as the relay does, using `lake env lean`.

usage: run_level.py GAME_DIR WORLD LEVEL PROOF_FILE [--difficulty N] [--inventory all|level|none]

The generated document mirrors relay/src/serverProcess.ts (lean4game v4.31.0):
    import <level module> import GameServer.Runner
    Runner "<game name>" "<world>" <level> (difficulty := N) (inventory := [...]) := by
    <proof lines>
Line numbers in Lean's output are therefore proof line + 2.
"""
import json, os, pathlib, subprocess, sys, argparse, re

ap = argparse.ArgumentParser()
ap.add_argument("game_dir"); ap.add_argument("world"); ap.add_argument("level", type=int)
ap.add_argument("proof_file", help="file with the player's proof lines, or - for stdin")
ap.add_argument("--difficulty", type=int, default=2, help="0 = no inventory checks, 1 = warnings, 2 = errors (game default)")
ap.add_argument("--inventory", default="all", help="all = every item in the game's inventory.json, level = items this level lists, none")
ap.add_argument("--open", action="append", default=[], help="namespace to `open` in the document header before Runner (experiment: what a lean4game-side fix would emit)")
a = ap.parse_args()

game_dir = pathlib.Path(a.game_dir).resolve()
gd = game_dir / ".lake" / "gamedata"
game = json.load(open(gd / "game.json"))
level = json.load(open(gd / f"level__{a.world}__{a.level}.json"))

def names(obj, keys=("tactics", "lemmas", "definitions")):
    out = []
    for k in keys:
        for t in obj.get(k, []) or []:
            n = t.get("name") if isinstance(t, dict) else t
            if n: out.append(n)
    return out

if a.inventory == "all":
    inv_path = gd / "inventory.json"
    inv = json.load(open(inv_path)) if inv_path.exists() else {}
    inventory = names(inv) or names(level)
elif a.inventory == "level":
    inventory = names(level)
else:
    inventory = []

proof = sys.stdin.read() if a.proof_file == "-" else open(a.proof_file).read()
opens = ''.join(f'open {ns}\n' for ns in a.open)
SHIFT = 2 + len(a.open)
doc = (f'import {level["module"]} import GameServer.Runner \n' + opens +
       f'Runner {json.dumps(game["name"])} {json.dumps(a.world)} {a.level} '
       f'(difficulty := {a.difficulty}) '
       f'(inventory := [{",".join(json.dumps(s) for s in inventory)}]) '
       f':= by\n{proof}\n')

out_dir = pathlib.Path(__file__).resolve().parent.parent / "runner-tests"
out_dir.mkdir(exist_ok=True)
stem = pathlib.Path(a.proof_file).stem if a.proof_file != "-" else "stdin"
doc_path = out_dir / f"{a.world}_{a.level}_{stem}.lean"
doc_path.write_text(doc)

# The game server runs Lean with the package's leanOptions (in particular linter.all=false, which
# silences Mathlib's unusedTactic/unreachableTactic linters); `lake env lean` does not, so pass them.
opts = ["-Dlinter.all=false", "-Dpp.showLetValues=true", "-Dtactic.hygienic=false"]
r = subprocess.run(["lake", "env", "lean", *opts, str(doc_path)], cwd=game_dir, capture_output=True, text=True)
out = (r.stdout + r.stderr).strip()
# Shift reported line numbers back to proof lines, like the relay does.
def shift(m):
    return f"{m.group(1)}:{max(0, int(m.group(2)) - SHIFT)}:{m.group(3)}:"
out = re.sub(re.escape(str(doc_path)) + r"()" + r":(\d+):(\d+):", shift, out)
print(f"### {a.world} level {a.level}  (difficulty {a.difficulty}, {len(inventory)} inventory items)  exit {r.returncode}")
print(out if out else "(no diagnostics: proof accepted)")
sys.exit(r.returncode)
