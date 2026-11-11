# UX notes from the Verbose spike (Emily's playtest)

Game: http://localhost:3000/#/g/local/VerboseGameSpike (lean4game v4.31.0, local)

For each level, note what felt good, what felt off, and anything you would change in the phrasing
or the layout. Screenshots are in `screenshots/` (taken by Claude from the built-in browser).

| Level                    | Phrases used                                                         | Typing effort (1–5) | Could you tell what to type without the hint? | Comments |
| ------------------------ | -------------------------------------------------------------------- | ------------------- | --------------------------------------------- | -------- |
| 1 Proving Implication    | `Assume p : P`, `We conclude by p`                                   |                     |                                               |          |
| 2 Introducing And        | `Let's first prove that P`, `Let's now prove that Q`                 |                     |                                               |          |
| 3 Using Or               | `We proceed using h`, `Let's prove that P`                           |                     |                                               |          |
| 4 Introducing Existence  | `Let's prove that false works`, `We conclude by rfl`                 |                     |                                               |          |
| 5 Induction              | `Let's prove by induction H : …`, `Fix`, `By h we get d such that …` |                     |                                               |          |
| 6 By Contradiction       | `Assume for contradiction hp : ¬ P`, `… applied to …`                |                     |                                               |          |
| 7 Using Functions (data) | `We conclude by f a`                                                 |                     |                                               |          |
| 8 Pairing (data)         | `Let's construct the pair` (prototype phrase)                        |                     |                                               |          |

## General

- Typewriter mode vs editor mode:
- Error messages when a phrase is slightly wrong:
- The `help` tactic (type `help` as a step):
- Goal display (e.g. "You need to announce: Let's now prove that Q"):
- Inventory tiles ("Assume", "We", "Let's", "Fix", "By"):
- Look and feel, things you would want different in a reimagined UI:

In level 1 in typewriter mode after clicking "help" I see:

Help
• The goal starts with “P ⇒ ...”
Hence a direct proof starts with:

malformed MsgEmbed: {"widget":{"alt":{"tag":[{"expr":{"text":"Assume that P"}},{"text":""}]},"wi":{"id":"Lean.Meta.Hint.textInsertionWidget","javascriptHash":"14102652505372521831","props":{"acceptSuggestionProps":{"hoverText":"Apply suggestion","kind":"text","linkText":"Assume that P"},"range":{"end":{"character":4,"line":0},"start":{"character":0,"line":0}},"suggestion":"Assume that P"}}}}

• The goal is an implication.
One can start a proof by contraposition using

malformed MsgEmbed: {"widget":{"alt":{"tag":[{"expr":{"text":"Let's prove the contrapositive: ¬P → ¬P"}},{"text":""}]},"wi":{"id":"Lean.Meta.Hint.textInsertionWidget","javascriptHash":"14102652505372521831","props":{"acceptSuggestionProps":{"hoverText":"Apply suggestion","kind":"text","linkText":"Let's prove the contrapositive: ¬P → ¬P"},"range":{"end":{"character":4,"line":0},"start":{"character":0,"line":0}},"suggestion":"Let's prove the contrapositive: ¬P → ¬P"}}}}

It feels weird to me that verbose doesn't end sentences with periods? Is there any rationale for this choice?

When I transitioned to level 3 the server crashed though after reload it seemed fine.

I tried level 3 using editor mode and weird things happened in the middle of typing the phrase "We proceed using hPQ." It seemed to try to update in the middle of my typing. Can it just wait until the end? It was very distracting. Then in the middle of typing the fourth line "Let's prove that P" it jumped me to level 4 and crashed the server. Once I restarted I saw "no goals" after typing just "We" rather than "We conclude by p". Typewriter mode seems fine but editor mode would be nice because you can see the whole proof more clearly.

The induction level is kind of tough because the user has to copy a lot of text from the goal to use the correct verbose commands. I wonder if there's a "tab complete mode" that could be turned on or off to help with the typing. We'll also need to teach the user to type various things like "\N" which I believe are not explained currently.

The hints are appearing too early in level 5. I'd like to see what to type one step at a time.

Actually I just discovered "assume hk : \_" works. It would be good to mention this explicitly in the documentation for assume. I think I like having two modes "Assume p : P" or "Assume that P"

I tried typing "By h we get m such that k = 2 _ m" it would be nice if this worked in addition to "By h we get m such that hm : k = 2 _ m"

When I type "We rewrite using hm" I see an error message "The tactic 'rewrite' is not available in this game!" Followed by "intermediate goal solved!" Note my game like the natural numbers game uses a weaker version of 'rw' that requires users to supply 'rfl' at the end. This could be the cause of the error?

After "By h we get m such that hm : k = 2 \* m + 1" I get another crash with the screen flashing back and forth between various things. This again happened in editor mode which is very buggy, though the glitching happened when I tried to switch back to typewriter mode.

It would be useful for the "We" documentation to expand out how to use rewrite (can you use it backwards) and what is meant by "We apply" and "We compute". What is "we compute?"

Right now I can't see any theorems or definitions.

Is "We conclude by b" for an element of a type, the Lean verbose style? I wonder if it would be natural to add something like "Let's use b"?

v2: I'm trying the entire game in editor mode. I still see weird things happening whenever I start with "We ..." It's like it's trying to update the state before I finish typing.

In level 3, I got "h*1" rather than "hQ" as the auto hypothesis after typing "Assume that *
We proceed using h
Assume that P
Let's prove that P
We conclude by hP
Assume that \_
Let's prove that Q
We conclude by h_1
"

In editor mode when writing the first line of level 4, I was jumped ahead to level 5. I went back but now it's taking forever for the goal to load.

Would it make sense to start level 5 with "Let's prove by induction that \_"

In general we could have better error messages. When I typed "We conclude by h" instead of "We proceed using h", it would be nice to have something explaining conclude is for supplying an element of the goal type, while proceed works on a hypothesis involving a disjunction.

It makes sense to have "Assume for contradiction that \neg P"
