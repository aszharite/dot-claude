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
4. **Present the complete plan.** Once every ambiguity is resolved, summarize the full resulting plan — every file to be touched, every command to be run, everything else with an effect — and get that confirmed before making any change. The plan should be the complete solution, not a partial one with more assumptions baked in silently between "clarified" and "executed."
5. **Then execute.** Only after the plan is confirmed.

## Why this overrides a "just proceed" default

Many agent harnesses default to resolving ambiguity via reasonable inference and moving on, to avoid friction. This rule intentionally overrides that default for any repository that includes it: the cost of an unwanted assumption (rework, silently wrong output, wasted time) is treated as higher than the cost of asking. If a harness's own instructions say to default to action rather than asking, this rule takes precedence for that repository.

This does not mean asking about things the repository, its files, or its history already answer — check those first. It means never substituting your own guess for the user's actual answer on anything those sources don't settle.
