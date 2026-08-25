---
title: "Production Readiness Review: <Service Name>"
description: Gate a service's first launch.
cadence: write-once
reviewer: <name>
date: <date>
status: Approved  # or: Blocked, Approved with follow-ups
---

# Production Readiness Review: <Service Name>

*One-time gate before first launch, distinct from a recurring per-release checklist.*

## Scope
What service/feature is going live, and when.

- State the actual launch scope precisely (full rollout vs. limited beta, which regions/customers) — a review approved for a beta shouldn't be treated as covering GA.
- Note the target date, since some checklist items (DR drills, load tests) need lead time to complete before it.

## Monitoring & alerting
Confirm dashboards and alerts exist and have been tested (not just configured).

- "Tested" means someone triggered the alert condition (or a synthetic version of it) and confirmed the page actually arrived — a rule that exists in config but has never fired is unverified.
- Confirm the `monitoring-plan.md` for this service actually exists and is linked, not assumed to be someone's mental model.

## On-call readiness
Confirm the service has a runbook, an on-call rotation, and the on-call engineer(s) have necessary access.

- Confirm the runbook covers this service specifically, not a generic template that was never filled in with real failure modes.
- Verify access, not just rotation assignment — someone can be scheduled on-call and still lack prod access if onboarding hasn't caught up.

## Rollback
Confirm a tested rollback path exists.

- "Tested" here means actually exercised in a non-prod environment, not just documented — a rollback path only discovered to be broken during a real incident defeats the purpose of this review.
- Confirm rollback covers any new data migrations too, since those are often the part that isn't simply reversible by redeploying the old version.

## Dependencies
Confirm upstream/downstream dependencies are known and their owners are aware this service is going live.

- Link the `dependency-map.md` for this service — if it doesn't exist yet, that's a gap this review should surface, not skip past.
- Confirm downstream teams were actually notified, not just theoretically knowable from an architecture diagram.

## Sign-off
Who needs to approve before this launches, and any conditions attached to approval.

- Name specific approvers, not a role or team — an unassigned sign-off is how launches slip through without anyone actually reviewing them.
- If approval is conditional ("approved with follow-ups"), list the follow-ups explicitly and where they're tracked, so "approved with conditions" doesn't quietly become "approved."
