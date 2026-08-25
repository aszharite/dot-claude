---
title: "Bug Report: <Short Title>"
description: Report one specific defect.
cadence: living
reporter: <name>
date: <date>
severity: Critical  # or: High, Medium, Low
status: Open  # or: In Progress, Fixed, Won't Fix
---

# Bug Report: <Short Title>

## Summary
One or two sentences describing the bug.

- Lead with the observable symptom, not your theory of the cause — "checkout button does nothing on click," not "checkout button has a race condition."
- Make it searchable: use the words a teammate would search for later, not a vague description that requires opening the report to understand what it's about.

## Steps to reproduce
1.
2.
3.

- Write steps precisely enough that someone unfamiliar with the feature can follow them without guessing — include starting state (logged in as which role, what data exists).
- Reduce to the minimum steps that still trigger it — extra steps that aren't necessary make it harder to tell what actually matters.
- If reproduction is intermittent, say so and note the rough frequency ("about 1 in 10 attempts") instead of listing steps that imply it's deterministic.

## Expected behavior

- State what should happen, referencing the spec/PRD/acceptance criteria if one exists rather than what "seems reasonable."
- If expected behavior is itself ambiguous or undocumented, say that — it may mean this is a spec gap, not just an implementation defect.

## Actual behavior

- Describe exactly what happens, including error messages, status codes, or screenshots — don't paraphrase an error message from memory.
- Distinguish what's visibly wrong from what you're inferring is wrong underneath it; keep inference out of this section and put it in Root cause once confirmed.

## Environment
Version, browser/OS, environment (prod/staging), and anything else needed to reproduce reliably.

- Include the specific version/build, not just "latest" — "latest" stops meaning anything the moment the next deploy ships.
- Note anything environment-specific that might be the actual cause (feature flag state, account type, locale, device) — bugs that only reproduce under specific config waste the most triage time when this is left out.

## Impact
Who/what is affected, and how badly?

- Quantify where possible: all users, a specific segment, a percentage of traffic — "some users" without a scope makes severity impossible to judge.
- Distinguish blocking (no workaround) from degraded (workaround exists) — this usually drives severity/priority more than the symptom itself.

## Root cause
Filled in once diagnosed — link to the fixing PR/ADR if the fix involved a design decision.

- Leave this blank until it's actually known — a guessed root cause that turns out wrong misleads whoever reads this report next.
- If the fix involved a real design tradeoff (not just a one-line patch), link the ADR or PR discussion rather than re-explaining the reasoning here.
