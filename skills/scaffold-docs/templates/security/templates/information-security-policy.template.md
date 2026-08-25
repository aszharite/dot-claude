---
title: "Information Security Policy: <Organization/Product Name>"
description: State the org's overall security approach — the cornerstone policy other security docs reference.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Information Security Policy: <Organization/Product Name>

*Cornerstone policy — other security docs should reference this, not restate it.*

## Purpose & scope
What this policy governs, and who it applies to.

- State who's bound by this — all employees, contractors, specific systems — explicitly; "everyone" is often assumed but rarely written down, and that's exactly what gets challenged during an audit.
- Distinguish this from the specific policies it points to: this doc sets intent and scope, the others (`access-policy.md`, `acceptable-use-policy.md`, etc.) set the specific rules.

## Principles
The org's overall approach to security (e.g. least privilege, defense in depth, data minimization).

- Name the actual principles this org has committed to, not a generic industry list — a principle nobody can point to a decision reflecting isn't really operating here.
- Keep this short enough that every other security document can credibly claim to follow it — a long list of aspirational values nobody checks against becomes decoration.

## Roles & responsibilities
Who owns security decisions, and who's accountable for what.

- Name actual roles (CISO, security lead, engineering managers), not "the security team" as a monolith — accountability needs a specific owner for each responsibility.
- Distinguish who *decides* (accepts risk, approves exceptions) from who *implements* — those are often different people, and conflating them is how decisions get made with no one actually accountable.

## Policy references
Link out to the specific policies this one is the parent of (access-policy, acceptable-use-policy, change-management-policy, data-classification-retention-policy, incident-response-plan, etc.) — this doc explains *why*, the linked policies explain *how*.

- Keep this as a list of links, not summaries — if a linked policy changes, this section shouldn't need editing too.
- If a policy referenced here doesn't exist yet, list it anyway as a known gap — an org that hasn't written its access policy yet should know that, not discover it during an audit.

## Exceptions
How exceptions to this policy get requested, approved, and tracked.

- Describe the process (who requests, who approves, where it's logged), not the exceptions themselves — those live in the specific policy they exempt.
- State whether exceptions expire by default or need an explicit review date — an exception process with no expiry mechanism tends to accumulate permanent holes.
