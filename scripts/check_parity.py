#!/usr/bin/env python3
"""Check that this game presents the same mathematics as the original Reintroduction to Proofs.

usage: check_parity.py UPSTREAM_DIR THIS_DIR [--allowlist parity-allowlist.txt]

Compared, level by level (Game/Levels/<World>/L*.lean on both sides):
  * the set of level files per world and the order in which the world file imports them,
  * `World`, `Level`, `Title`,
  * the `Statement` header: name, binders and type, from `Statement` up to `:= by`
    (whitespace-normalised; the proof is not compared),
  * the docstring of the `Statement` (reported as a warning only),
and the `Dependency` lines of Game.lean.

An allowlist file may contain lines `<World>/<file-stem>:<field>` (fields: statement, title,
docstring, level) or `world:<World>` to ignore a whole world.
"""
import argparse, pathlib, re, sys

def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()

def parse_level(path: pathlib.Path) -> dict:
    text = path.read_text(encoding="utf-8")
    out = {}
    for key in ("World", "Level", "Title"):
        m = re.search(rf'^{key}\s+(.+)$', text, re.M)
        out[key.lower()] = norm(m.group(1)) if m else None
    m = re.search(r'^Statement\b(.*?):=\s*by\b', text, re.M | re.S)
    out["statement"] = norm(m.group(1)) if m else None
    if m:
        before = text[:m.start()]
        d = re.search(r'/--(.*?)-/\s*$', before, re.S)
        out["docstring"] = norm(d.group(1)) if d else None
    else:
        out["docstring"] = None
    return out

def world_imports(path: pathlib.Path):
    return [l.split(".")[-1].strip() for l in path.read_text().splitlines() if l.startswith("import Game.Levels.")]

def collect(root: pathlib.Path):
    levels = {}
    worlds = {}
    base = root / "Game" / "Levels"
    for wf in sorted(base.glob("*.lean")):
        worlds[wf.stem] = world_imports(wf)
    for lf in sorted(base.glob("*/L*.lean")):
        levels[f"{lf.parent.name}/{lf.stem}"] = parse_level(lf)
    deps = [norm(l) for l in (root / "Game.lean").read_text().splitlines() if l.startswith("Dependency")]
    return levels, worlds, deps

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("upstream"); ap.add_argument("this")
    ap.add_argument("--allowlist", default="parity-allowlist.txt")
    a = ap.parse_args()
    allow = set()
    p = pathlib.Path(a.this) / a.allowlist
    if p.exists():
        allow = {l.strip() for l in p.read_text().splitlines() if l.strip() and not l.startswith("#")}
    up_levels, up_worlds, up_deps = collect(pathlib.Path(a.upstream))
    my_levels, my_worlds, my_deps = collect(pathlib.Path(a.this))
    errors, warnings = [], []
    def skip(key, field):
        return key + ":" + field in allow or "world:" + key.split("/")[0] in allow
    if up_deps != my_deps:
        errors.append("Game.lean Dependency lines differ:\n  upstream: " + " | ".join(up_deps) + "\n  here:     " + " | ".join(my_deps))
    for w, imps in up_worlds.items():
        if "world:" + w in allow: continue
        if w not in my_worlds: errors.append(f"world {w} missing here"); continue
        if imps != my_worlds[w]: errors.append(f"world {w}: level order/import list differs\n  upstream: {imps}\n  here:     {my_worlds[w]}")
    for w in my_worlds:
        if w not in up_worlds and "world:" + w not in allow: errors.append(f"world {w} exists here but not upstream")
    for key, up in up_levels.items():
        if key not in my_levels:
            if not skip(key, "level"): errors.append(f"{key}: level missing here")
            continue
        me = my_levels[key]
        for field in ("world", "level", "title", "statement"):
            if up[field] != me[field] and not skip(key, field):
                errors.append(f"{key}: {field} differs\n  upstream: {up[field]}\n  here:     {me[field]}")
        if up["docstring"] != me["docstring"] and not skip(key, "docstring"):
            warnings.append(f"{key}: statement docstring differs")
    for key in my_levels:
        if key not in up_levels and not skip(key, "level"): errors.append(f"{key}: level exists here but not upstream")
    for w in warnings: print("warning:", w)
    for e in errors: print("ERROR:", e)
    print(f"\n{len(up_levels)} upstream levels, {len(my_levels)} here, {len(errors)} error(s), {len(warnings)} warning(s)")
    sys.exit(1 if errors else 0)

if __name__ == "__main__":
    main()
