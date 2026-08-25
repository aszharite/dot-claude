---
title: "Performance Test Plan: <System/Feature Name>"
description: Plan load or stress testing.
cadence: living
owner: <name>
updated: <date>
---

# Performance Test Plan: <System/Feature Name>

## Objective
What question is this test answering (can we handle X load, what's our breaking point, has a change regressed latency)?

- Phrase it as a specific question with a yes/no or numeric answer — "test performance" isn't an objective; "can the API sustain 500 RPS at p95 < 200ms" is.
- State what triggered this test (an upcoming launch, a suspected regression, a capacity planning cycle) — it shapes which scenarios matter and what counts as good enough.

## Load scenarios
| Scenario | Concurrent users/RPS | Duration | Ramp-up |
|---|---|---|---|

- Base scenarios on real or projected traffic patterns, not round numbers picked for convenience — link to actual traffic data or a capacity-planning estimate if one exists.
- "Ramp-up" matters as much as peak load — a sudden spike and a gradual climb to the same peak can produce very different failure modes.
- Include at least one scenario beyond expected peak (to find the breaking point), not only scenarios you already expect to pass.

## Pass/fail criteria
Target latency (p50/p95/p99), error rate threshold, and resource utilization limits.

- Set numeric thresholds before running the test, not after looking at results — criteria chosen post-hoc aren't criteria, they're rationalization.
- Include error rate and resource utilization alongside latency — a system can hit its latency target while quietly approaching a CPU or memory ceiling that fails under slightly more load.
- Tie thresholds back to an actual requirement or SLO where one exists (`operations/slo-definitions.md`) rather than inventing a number that sounds reasonable.

## Environment
Where this runs, and how it differs from production (scaled-down infra, synthetic data) — note anything that limits how representative results are.

- Name every material difference from production (instance size, data volume, downstream services mocked or real) — each one is a reason results might not transfer.
- If the environment is meaningfully smaller than prod, say how results were scaled or extrapolated, if at all — an unscaled number from a scaled-down environment is misleading on its own.

## Results
Filled in after execution — actual numbers against the criteria above, and the go/no-go call.

- Report actual numbers against each criterion from "Pass/fail criteria" side by side, not just a pass/fail verdict — the margin matters as much as the outcome.
- Note anything unusual about the run itself (a network blip, resource contention with another test) that might make the numbers unrepresentative.
- State the go/no-go call explicitly, and what would need to change to flip it if it's a no-go.
