---
title: "ADR-0001: <Decision Title>"
description: Record one architectural decision.
cadence: append-only
date: <date>
status: Proposed  # or: Accepted, Superseded by ADR-XXXX
---

# ADR-0001: <Decision Title>

## Context
What forces/constraints led to needing this decision?

- What was already true before this decision was needed — the technical, organizational, or business constraint that made the status quo untenable?
- What options were even on the table, and what made this the moment to decide rather than defer?
- Name the forces in tension (e.g. cost vs. latency, consistency vs. availability, speed vs. correctness) — an ADR that doesn't name a real tradeoff usually wasn't a decision worth recording.

*Write this section as if the decision hadn't been made yet — a reader six months from now should understand the constraints without already knowing the answer.*

## Decision
What did we decide?

- State the decision as a single, unambiguous sentence a future reader could act on without re-deriving the reasoning.
- If the decision has multiple parts (a technology choice plus a rollout approach, say), separate them so each can be superseded independently later.

## Alternatives considered
List other options and why they were rejected.

- Include the option of doing nothing, or of doing the naive/default thing — it's the baseline every other option is implicitly compared against.
- For each alternative, give the specific reason it lost (cost, risk, team familiarity, a constraint from Context) rather than a vague "didn't fit."
- Resist listing options nobody seriously considered just to pad this section — it should reflect the actual debate that happened.

## Consequences
What becomes easier or harder as a result? Any follow-up work created?

- Name what this decision forecloses, not just what it enables — every real decision has a cost, and pretending otherwise makes this ADR read as marketing rather than a record.
- Call out any follow-up work (migrations, new operational burden, a deprecation timeline) this decision creates, even if it's tracked elsewhere.

---
ADRs are append-only. Never edit or delete a past decision — supersede it with a new numbered ADR that links back.
