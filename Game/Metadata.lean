import GameServer
import Verbose.English.All

import Game.Metadata.Equivalence
import Game.Metadata.Tactic
import Game.Metadata.Tactic.Construct
import Game.Metadata.Tactic.NamedPhrases
import Game.Metadata.Tactic.Synonyms
import Game.Metadata.Tactic.Help
import Game.Metadata.Tactic.Overrides
import Game.Metadata.Tactic.Cases

/-! Everything that should be available in every level.

This is the Verbose Lean edition of Reintroduction to Proofs. Players interact with Lean through
Verbose Lean's controlled English (`Assume h : P`, `We conclude by h`, `Let's prove that x
works`, …) plus the game's own construction phrases (`Let's use a`, `Let's construct it
componentwise`, `Let's consider all cases for b`, …) defined in `Game/Metadata/Tactic/`.

`Game.Metadata.Tactic` still provides the original game's custom tactics (`rw`, `use`,
`induction … with`, `constructor`) for the levels that have not been ported yet; it goes away once
the port is complete. The `ℕ` notation now comes from Mathlib (through Verbose).

Verbose configuration: classical case analysis is enabled; the ProofWidgets suggestion panel and
Verbose's own `help` are disabled because the game server cannot render widgets
(`Game/Metadata/Tactic/Help.lean` provides a plain-text `help` instead). -/

configureAnonymousCaseSplittingLemmas Classical.em
disableWidget
disableHelpTactic
