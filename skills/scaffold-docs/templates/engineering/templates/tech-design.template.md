---
title: "Technical Design: <Feature/Change Name>"
description: Propose a single feature's implementation approach before writing code.
cadence: write-once
author: <name>
updated: <date>
status: Draft  # or: In Review, Approved
---

# Technical Design: <Feature/Change Name>

## Problem
What are we building, and what constraints (performance, scale, compatibility) does the solution need to satisfy?

- State the problem independent of the solution you already have in mind — if this reads identically to the Proposed design section, back up a level.
- Name the hard constraints (must not break an existing API, must handle current traffic volume, must ship before a deadline) that any valid design has to satisfy.

## Proposed design
How will it work? Cover the approach at a level a reviewer can critique without reading the code.

- Describe the approach in enough detail that a reviewer could poke a hole in it — data flow, key components touched, and the shape of any new interfaces.
- Call out where this touches existing systems and what changes for them, not just what's new.

*A reviewer should be able to say "this won't handle case X" from this section alone — if the only way to find that gap is reading the diff, this section is too thin.*

## Alternatives considered
Other approaches and why they were rejected — same spirit as an ADR, but scoped to one feature's implementation rather than a standalone decision.

- Include the simplest approach that could plausibly work, even if you rejected it — it sets the baseline the chosen design is being justified against.
- Give a concrete reason each alternative lost (performance, complexity, doesn't fit existing patterns), not just "we preferred the other option."

## Risks & open questions
What could go wrong, and what's still unresolved before implementation starts?

- Separate risks (things that might go wrong even if the design is right — a dependency's rate limits, an untested assumption about data volume) from open questions (things that need an answer before or during the build).
- Assign an owner to each open question that blocks starting work; an unresolved question with no owner tends to stay unresolved until it becomes an incident.

## Rollout plan
Feature flags, migration steps, phased rollout — how does this go from merged to fully live?

- Describe how this ships incrementally if it can: behind a flag, to a percentage of traffic, to internal users first — "merge and it's live for everyone" is a valid answer, but should be a deliberate choice, not a default.
- Name the rollback path: if this needs to be turned off after it's live, what does that require (a flag flip, a revert, a data cleanup)?
