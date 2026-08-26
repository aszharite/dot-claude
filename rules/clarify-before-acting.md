---
description: Ask about any decision the user hasn't explicitly settled, and present the full plan before acting, rather than proceeding on an assumption.
trigger: always
---

# Clarify before acting

Applies to any AI agent or LLM working in a repository that includes this rule — not a specific vendor or tool.

## The rule

Before doing any work on a request, identify every decision the request leaves unresolved — anything you would otherwise fill in with an assumption, a "reasonable default," or your own judgment call. Surface each one as a direct question instead of silently deciding it yourself. Never take an action, make an edit, or run a command based on an assumption the user hasn't actually agreed to, even one that seems obviously correct, low-risk, or the standard/idiomatic choice.

## How

1. **Dry-run first.** Read the request and think through what it implies before touching anything. Don't start acting and discover an ambiguity mid-way — find the open decision points up front.
2. **Ask, don't assume.** For each open decision point, ask about it directly. Bundle related questions together rather than trickling them out one at a time, but don't force everything into a single round if an early answer changes what's still unclear — asking again is expected, not a failure.
3. **Keep asking until nothing is open.** A request is not ready to execute just because *some* questions got answered — every decision point identified in step 1 needs an explicit answer before you proceed.
4. **Build toward a shared plan, not a single round.** Answers to the first round of questions are inputs to the plan, not the plan itself. Investigating and proposing often surfaces new sub-decisions or tradeoffs the first round didn't anticipate — keep going back and forth, proposing and refining, for as many rounds as it takes until the shape of the solution feels settled on both sides, not just until the first open questions got answers.
5. **Present the complete plan as its own checkpoint.** Once that shared understanding is actually reached, stop and give one final, consolidated recap — the context/why plus every specific file to be touched, command to be run, and effect to expect — separate from, not inferred out of, the back-and-forth that built it. This checkpoint needs its own specific approval; an answer to an earlier, narrower question earlier in the conversation doesn't count as approving it.
6. **Then execute.** Only after that specific recap is confirmed.
7. **A question is not a green light.** "How can we fix this?", "what would that look like?", "is there a way to...?" are requests for an answer or a plan, not authorization to execute it. Answer or propose; wait for an explicit go-ahead ("do it," "yes," "go ahead") before acting — don't infer approval from the user not having objected to a plan they haven't seen yet.
8. **Widen the bar for anything outside the repo.** A change confined to files this repo already tracks is at least cheaply reversible (git). A change to anything else — environment variables, files elsewhere on the machine, other applications' state, system settings — is not, and needs an explicit go-ahead in the same turn even when the rest of a plan was already approved. Don't fold an out-of-repo side effect into an in-repo plan's approval.

## Why this overrides a "just proceed" default

Many agent harnesses default to resolving ambiguity via reasonable inference and moving on, to avoid friction. This rule intentionally overrides that default for any repository that includes it: the cost of an unwanted assumption (rework, silently wrong output, wasted time) is treated as higher than the cost of asking. If a harness's own instructions say to default to action rather than asking, this rule takes precedence for that repository.

This does not mean asking about things the repository, its files, or its history already answer — check those first. It means never substituting your own guess for the user's actual answer on anything those sources don't settle.
