---
title: "Capacity Planning: <Service/System Name>"
description: Plan for scale before it becomes an incident.
cadence: living
owner: <name>
updated: <date>
---

# Capacity Planning: <Service/System Name>

## Current capacity
What the system currently handles (throughput, storage, concurrent users), and current headroom.

- Use real measured numbers from monitoring, not the theoretical maximum from a spec sheet — the two are often far apart.
- State headroom as both a number and a time horizon ("we're at 60% of capacity, which buys ~4 months at current growth") — a raw percentage alone doesn't say when to worry.
- Note if headroom differs sharply across resources (CPU fine, disk tight) — a single blended figure can hide the one dimension about to run out.

## Growth forecast
Expected growth over the next planning period, and what's driving it.

- Ground the forecast in a real driver (user growth trend, a known upcoming launch, a seasonal pattern), not a flat extrapolation, if a real driver exists.
- Call out step-function events separately from organic growth (a marketing campaign, a new customer onboarding at 10x normal volume) — those break a smooth-growth model.
- State the confidence level or range, not just a point estimate — planning off a false-precision number leads to either over- or under-provisioning.

## Scaling thresholds
The specific levels at which action needs to happen, defined before you're at them.

| Metric | Current | Threshold to act | Action when reached |
|---|---|---|---|

- Set the "threshold to act" well before the actual limit — the lead time below has to fit inside the gap between threshold and failure.
- "Action when reached" should be a specific, already-decided step, not "evaluate options" — deciding under pressure is how a capacity issue becomes an outage.

## Scaling approach
Vertical vs horizontal, autoscaling vs manual, and any known bottlenecks that won't scale simply.

- Name the specific bottleneck resource if scaling isn't uniform (e.g. compute autoscales fine, but the database is a single primary that doesn't).
- If autoscaling is in place, note its limits (max instance count, cooldown periods) — autoscaling that silently caps out looks identical to no autoscaling until it's tested.

## Lead time
How much advance notice is needed to provision additional capacity (e.g. hardware order times, quota increases).

- Include every step in the lead time, not just the fastest one — a cloud quota increase might need vendor approval that takes longer than the resize itself.
- If lead time varies a lot by scale (10% more capacity vs. doubling), give both, since the triggering scenario matters.
