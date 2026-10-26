import Verbose.English.All
import Game.Metadata.Tactic.Synonyms
import Game.Metadata.Tactic.Construct

/-! # Extra `help` providers for this game

Verbose's `help` knows about propositions. This game also asks players to *construct* elements
of types, and its most common step is "the goal is one of your assumptions". These two providers
cover those cases; they are enabled in `Game/Metadata.lean` with `configureHelpProviders`. -/

open Lean Meta Elab Tactic Verbose

/-- Suggest `Let's use h` / `We conclude by h` when some assumption has exactly the goal's type. -/
@[goalHelp _]
def gameHypothesisGoal : GoalHelpExt where
  run (goal : MVarId) (_g : VExpr) : SuggestionM Unit := goal.withContext do
    let tgt ← instantiateMVars (← goal.getType)
    let isProp ← isProp tgt
    for decl in (← getLCtx) do
      if decl.isImplementationDetail then continue
      if ← isDefEq decl.type tgt then
        let h := mkIdent decl.userName
        if isProp then
          pushCom "The goal is exactly the statement of your assumption {decl.userName}."
          pushTac `(tactic| We conclude by $h:ident)
        else
          pushCom "Your context already contains an element of the goal type, namely {decl.userName}."
          pushTac `(tactic| Let's use $h:ident)
        flush

/-- Suggestions for goals that are types rather than propositions. -/
@[goalHelp _]
def gameDataGoal : GoalHelpExt where
  run (goal : MVarId) (_g : VExpr) : SuggestionM Unit := goal.withContext do
    let tgt ← instantiateMVars (← goal.getType)
    if ← isProp tgt then return
    let tgtW ← whnfR tgt
    let tS ← ppExpr tgt
    if tgtW.isForall then
      let dom := tgtW.bindingDomain!
      let domS ← PrettyPrinter.delab dom
      let x := mkIdent (← goal.getUnusedUserName (if tgtW.bindingName!.isAnonymous then `a else tgtW.bindingName!.eraseMacroScopes))
      pushCom "The goal {tS} is a function type. A construction starts by fixing an input:"
      pushTac `(tactic| Fix $x:ident : $domS)
      flush
      return
    if tgtW.isAppOfArity ``Sum 2 then
      let aS ← PrettyPrinter.delab (tgtW.getArg! 0)
      let bS ← PrettyPrinter.delab (tgtW.getArg! 1)
      pushCom "The goal {tS} is a sum type: an element comes from one of the two summands. Choose which one:"
      pushTac `(tactic| Let's construct an element of $aS)
      flush
      pushCom "or:"
      pushTac `(tactic| Let's construct an element of $bS)
      flush
      return
    if tgtW.isAppOfArity ``Prod 2 then
      pushCom "The goal {tS} is a product type: build it from its two components."
      pushTac `(tactic| Let's construct the pair)
      flush
      return
    if tgtW.isAppOfArity ``Unit 0 ∨ tgtW.isAppOfArity ``PUnit 1 then
      pushCom "The goal {tS} has the canonical element ⟨⟩."
      pushTac `(tactic| Let's use ⟨⟩)
      flush
      return
    if let .const n _ := tgtW.getAppFn then
      if isStructure (← getEnv) n then
        pushCom "The goal {tS} is a structure: build it from its components, in order."
        pushTac `(tactic| Let's construct it componentwise)
        flush
        return
    -- Otherwise: look for functions into the goal, or an impossibility, in the context.
    for decl in (← getLCtx) do
      if decl.isImplementationDetail then continue
      let ty ← whnfR decl.type
      if ty.isAppOfArity ``Empty 0 then
        pushCom "Your context contains {decl.userName} : Empty, so this case cannot occur."
        pushTac `(tactic| This is impossible because of $(mkIdent decl.userName):ident)
        flush
      else if ty.isForall ∧ !ty.bindingBody!.hasLooseBVars then
        if ← isDefEq ty.bindingBody! tgt then
          let f := mkIdent decl.userName
          pushCom "The function {decl.userName} produces elements of the goal type; applying it changes the goal to its input type."
          pushTac `(tactic| We apply $f:ident)
          flush

/-- Verbose's implication provider (`Assume hyp : A`) also fires on function types between
types, where only `Fix` applies. This wrapper runs it for propositions only; it replaces
`helpImplicationGoal` in the configured list. -/
@[goalHelp _]
def gameImplicationGoal : GoalHelpExt where
  run (goal : MVarId) (g : VExpr) : SuggestionM Unit := do
    if ← goal.withContext (isProp (← goal.getType)) then
      helpImplicationGoal.run goal g
