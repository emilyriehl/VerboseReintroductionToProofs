import Verbose.English.All

/-! # Verbose "Named" phrases, made global

Verbose Lean keeps the phrases that name a hypothesis (`Assume h : P`, `Claim h : P from …`,
`Let's prove by induction H : …`) behind `scoped` syntax in the namespaces `Verbose.Named` and
`Verbose.NameLess`, so that a teacher can `open` one style per file.

The game server parses a player's input *before* it re-applies the level file's `open`
declarations (see `GameServer.Runner`), so scoped syntax never reaches the player. We therefore
re-declare the Named phrases here without `scoped`; the definitions are copied from
`Verbose/English/{Assume,Claim,Lets}.lean` (tag v4.31.0) and delegate to Verbose's own
elaborators. Level files must NOT `open Verbose.Named` on top of this (it would create ambiguous
parses). -/

open Lean Elab Tactic Verbose.English

-- From Verbose/English/Assume.lean (namespace Verbose.Named)
syntax "Assume " (colGt assumeDecl)+ : tactic
syntax "Assume " "for contradiction " (colGt assumeDecl) : tactic

macro_rules
  | `(tactic| Assume $decl:assumeDecl) => `(tactic| Assume₁ $decl)
  | `(tactic| Assume $decl:assumeDecl $decls:assumeDecl*) => `(tactic| Assume₁ $decl; Assume $decls:assumeDecl*)

elab_rules : tactic
  | `(tactic| Assume for contradiction $x:ident : $type) => forContradiction x.getId type

-- From Verbose/English/Claim.lean (namespace Verbose.Named); the game offers `Claim` only, not `Fact`.
macro "Claim" name:ident ":" stmt:term "by" colGt prf:tacticSeq: tactic =>
 withRef name  `(tactic|(checkName $name; have $name : $stmt := by $prf))

macro "Claim" name:ident ":" stmt:term "from" prf:maybeApplied : tactic => do
 withRef name  `(tactic|(checkName $name; have $name : $stmt := by We conclude by $prf))

macro "Claim" name:ident ":" stmt:term "by computation" : tactic => do
 withRef name  `(tactic|(checkName $name; have $name : $stmt := by We compute))

macro "Claim" name:ident ":" stmt:term "since" facts:facts : tactic =>
 withRef name  `(tactic|(checkName $name; have $name : $stmt := by Since $facts we conclude that $stmt))

-- The induction phrases live in Game/Metadata/Tactic/Overrides.lean (they accept `_`).
