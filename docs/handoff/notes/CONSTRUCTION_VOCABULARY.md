# Construction vocabulary: what the data worlds need (proposal for Emily)

Verbose Lean has no register for *building elements of types*. Below, every construction
pattern that occurs in Reintroduction to Proofs, what stock Verbose already does for it
(tested in the spike, `runner-tests/DataTest.lean`), and candidate phrases where something is
missing. Phrases marked ✓ exist; ✎ are game-defined already; ? need a decision.

| Pattern (original tactic) | Example level | Verbose / game phrase | Status |
|---|---|---|---|
| Supply an element: `exact a`, `assumption` | TypeWorld L01–L03, FunctionWorld L02 | `Let's use a` (✎ synonym of `We conclude by a`) | ✎ works |
| Supply a type or proposition: `exact Prop`, `exact Q` | TypeWorld L05, L07 | `Let's use Prop` | works (same phrase) |
| Define a function: `intro a` | FunctionWorld L01, L05… | `Fix a : A` | ✓ (only introduces data; `Assume` only hypotheses) |
| Apply a function backwards: `apply f` | FunctionWorld L03 | `We apply f` | ✓ |
| Build with a term: `exact fun a ↦ g (f a)` | FunctionWorld L04 | `Fix a : A` then `Let's use g (f a)`, or `Let's use fun a ↦ g (f a)` | ✓ |
| Local definition: `let b := f a` | ProductWorld L10 | `Set b := f a` | ✓ |
| Pair: `constructor` on `A × B` | ProductWorld L01 | `Let's construct the pair` (✎) | ✎ works; naming is open (`Let's build the pair`, `Let's give both components`?) |
| Pair directly: `exact ⟨a, b⟩` | ProductWorld L01 | `Let's use ⟨a, b⟩` | works |
| Projections / destructure a pair: `p.1`, `rcases p with ⟨a, b⟩` | ProductWorld L02–L03, L08 | `Let's use p.1`; `By p we get (a : A) (b : B)` | ✓ (surprisingly, Verbose's `By … we get` works on pairs) |
| Injections: `left`/`right`, `Sum.inl a` on `A ⊕ B` | CoproductWorld L01–L02 | `Let's use Sum.inl a`; stock `Let's prove that A` does not apply to sums | ? candidate: `Let's use the left component a` / `Let's build a left element from a` |
| Case analysis on a sum: `rcases s with a \| b` | CoproductWorld L03–L08, EmptyWorld | `We proceed using s` (✎ extended to sums: one goal per summand, then `Fix a : A`) | ✎ to be verified in this build |
| Empty elimination: `exact e.elim`, `cases e` | EmptyWorld | `Let's prove it's contradictory` then `Let's use e.elim`; reads oddly for data | ? candidate: `This case is impossible because of e` / `Since e : Empty this case cannot occur` |
| Function on `Bool` by cases: `intro b; match b with …` | BooleanWorld L01–L09 | `Fix b : Bool` then `We proceed depending on b` fails (stock version is for propositions) | ? candidate: `We proceed depending on whether b is false or true` → `cases b` (two goals, both `Bool`); or one-line `Let's use fun b ↦ match b with …` |
| Function on ℕ by recursion | NaturalNumbersWorld L04, L06 | nothing | ? candidate: `We define it by recursion on n` → `induction n` with data motive |
| Build an equivalence `A ≃ B` (4 fields) | EquivalenceWorld | `Let's construct the pair` works for any structure (it is `fconstructor`) but the name is wrong | ? candidate: `Let's construct the equivalence` or a generic `Let's construct it componentwise` |
| Dependent pairs / functions | DependentWorld | same as pairs / functions | covered once the above are chosen |
| Existential whose witness is a function | BooleanWorld L01, L03, L05, L09 | `Let's prove that (fun b ↦ …) works` then `Let's first prove that …`, `We compute` | ✓ (tested) |

Observations for the decision:
- Verbose's own phrases already carry most of the data worlds: `Fix`, `Let's use`, `Set`,
  `By p we get`, `We apply`. Only four genuinely new phrases are needed: sum injections, case
  analysis on data (sums, booleans, naturals), `Empty`, and "construct componentwise" for
  structures. Everything else is naming.
- Keep one verb per idea: "use" to supply, "construct" to split a goal into components,
  "proceed" to split on a hypothesis. Then the Curry–Howard parallel can be stated in
  Conclusions: `Let's first prove that P` is `Let's construct the pair` for propositions, `We
  proceed using h` is the same phrase for `∨` and `⊕`, `Fix` is `Assume` for data.
- `Let's construct the pair` could become `Let's construct it componentwise` (works for `×`,
  `Σ`, `≃`, `∧`, `↔`) if a single phrase for all structures is preferred over per-type wording.

## Decisions after Emily's review (2026-10-26) and the prototype

All phrases below exist in the spike (`Game/Metadata/Tactic/{Construct,Cases,Synonyms}.lean`)
and were verified with `runner-tests/DataTest2.lean`.

| Idea | Phrase | Notes |
|---|---|---|
| Supply an element or proof | `Let's use a` | synonym of `We conclude by a` |
| Destructure a pair / conjunction | `By p we get a : A and b : B` (also `(a : A) and (b : B)`, `a and b`) | Emily's sentence; Verbose's own form `By p we get (a : A) (b : B)` still works |
| Build a pair or any structure | `Let's construct it componentwise` (and `Let's construct the pair`) | `fconstructor`, goals in field order |
| Sum injection | `Let's construct an element of A` | on a goal `A ⊕ B` picks the summand whose type is `A`; harmless when the goal already is `A` |
| Case analysis on data (`Bool`, `A ⊕ B`, `ℕ` without recursion) and on `h : P ∨ Q` | `Let's consider all cases for b`, then `Let's first consider the case where b is false`, `Let's next consider the case where b is true` | the "all cases" line is optional (`Let's first consider …` splits by itself); cases may be taken in any order; `first`/`next`/`now` are optional words; constructor fields are named in the announcement (`s is inl a`, `n is succ k`); unannounced cases display as "You need to announce: Let's consider the case where s is inl val" |
| Recursion on `ℕ` for data | `Let's define it by recursion on n`, then the same case announcements; in the `succ k` case the recursive value is introduced with `Fix r : C k` | wording for the recursive value is still open ("with the value for k called r"?) |
| Impossible case | `This is impossible because of e` | works for `e : Empty`, `h : False`, and `h applied to p` with `h : ¬P`, `p : P`; Emily's other suggestion "The case e : Empty cannot occur" can be added as a synonym |
| Existential whose witness is a function | no new phrase | keep the original levels' `preamble` (it splits the goal into "define the function", a data goal solved with `Fix`/cases/`Let's use`, and "check it", solved with `Let's first prove that …` / `We compute`), so players never type `fun` |
| Lambda syntax | `fun b ↦ …` where unavoidable | Lean needs `fun`; teach it where it appears (FunctionWorld composition levels) |

Unchanged from before: `Fix a : A` for data introduction, `We apply f`, `Set b := f a`, `We proceed
using h` for `∨` and `⊕` (kept as an alternative to the case phrases).
