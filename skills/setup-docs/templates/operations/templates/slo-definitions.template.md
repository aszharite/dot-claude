---
title: "SLO Definitions: <Service Name>"
description: Define reliability targets for a service.
cadence: living
owner: <name>
updated: <date>
---

# SLO Definitions: <Service Name>

## Service level indicators (SLIs)
What's measured (e.g. request latency, availability, error rate), and how.

- Define the measurement precisely enough that two people would compute the same number from the same data — "availability" needs a definition of what counts as "up."
- Measure as close to the user's experience as possible (client-observed latency beats server-side timing) if the data is available; note when it isn't and what proxy is used instead.
- State what's explicitly excluded from the SLI (planned maintenance windows, known third-party outages) if anything is.

## Service level objectives (SLOs)
The target for each SLI and the window it's measured over — this is the number the team is actually accountable to.

| SLI | Target | Measurement window |
|---|---|---|

- Set the target from what users actually need, not from what the system currently achieves — an SLO copied from current performance isn't a target, it's a status report.
- Choose the measurement window deliberately (rolling 28 days vs. calendar month) — a short window makes the error budget noisy; a long one makes it slow to detect regressions.

## Error budget
How the error budget is calculated from the SLO, and what happens when it's exhausted (e.g. feature freeze).

- Show the actual calculation (e.g. "99.9% target over 30 days = 43 minutes of allowed downtime") so the abstract percentage becomes a concrete number people can reason about.
- State the exhaustion policy as something that actually happens, not aspirationally — a feature freeze that's never enforced isn't a real error budget.

## Consequences
What action is triggered by breaching an SLO — paging, postmortem requirement, roadmap reprioritization.

- Distinguish an error-budget burn-rate alert (fast, page-worthy) from a monthly SLO miss (slower, review-worthy) — they call for different responses.
- Name who has authority to invoke the consequence (freeze releases, reprioritize the roadmap) — a consequence with no one empowered to enforce it won't happen.
