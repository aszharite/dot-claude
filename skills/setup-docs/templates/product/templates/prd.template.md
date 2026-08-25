---
title: "PRD: <Feature/Product Name>"
description: Define what to build and why.
cadence: living
owner: <name>
updated: <date>
status: Draft  # or: In Review, Approved
---

# PRD: <Feature/Product Name>

## Problem
What user or business problem does this solve, and why is now the right time to solve it?

- What's happening today without this — what's broken, missing, or manual?
- Who feels this problem, and how often?
- What triggered this now (a metric, a complaint pattern, a competitive gap, a strategic bet)?
- What happens if we do nothing?

*Keep this to the problem, not the solution — if you're already describing a UI or an API here, back up a level.*

## Goals & Non-Goals
State what this specifically will and won't do. The non-goals matter as much as the goals — they're what keeps scope from creeping mid-build.

- Goals: the outcomes this needs to achieve, phrased as results, not features (e.g. "reduce checkout abandonment by X%," not "add a progress bar").
- Explicit non-goals (scope boundaries): adjacent things people will assume are included unless you say otherwise. If reviewers keep asking "does this cover X?", the answer belongs here.

## Users & Use Cases
Who is this for, and what are the key scenarios?

- Name the specific user segment(s) — not "users," but which ones, and why them first.
- Walk through 2-3 real scenarios: what the user is trying to do, their context, and what success looks like for them.
- If a persona already exists for this audience, link to it (`/docs/product/templates/persona.template.md`) instead of re-describing them here.

## Requirements
Numbered, testable requirements. Each should be verifiable — link to /docs/testing/test-plan.md once it exists.

1.
2.

- Write requirements as outcomes ("the system must X when Y"), not implementation ("use a Redis cache") — implementation belongs in a tech-design, not here.
- Each requirement should map to at least one test case once a test plan exists for this feature — if you can't picture how you'd test a requirement, it's probably not specific enough yet.
- Mark which requirements are hard requirements vs. nice-to-haves; don't let scope quietly expand because everything reads as equally mandatory.

## Success Metrics
How will we know this worked? Include target numbers where possible.

- Pick metrics that were knowable *before* you built this, not ones invented afterward to justify it.
- Include a target number and a timeframe where you can (e.g. "reduce median time-to-first-action from 40s to under 15s within 30 days of launch"), not just a direction.
- If a metric can't be measured with current instrumentation, say so — that's a dependency, not a detail to skip.

## Open Questions
Anything genuinely unresolved that shouldn't block writing this PRD but does need an answer before or during build.

- Distinguish questions that block *starting* work from ones that can be answered *during* work.
- Assign an owner to each question if you can — an open question nobody's responsible for closing tends to stay open forever.
