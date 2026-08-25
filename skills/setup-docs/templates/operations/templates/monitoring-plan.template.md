---
title: "Monitoring Plan: <Service/Feature Name>"
description: Define what to monitor and alert on for a specific service or feature.
cadence: living
owner: <name>
updated: <date>
---

# Monitoring Plan: <Service/Feature Name>

## What we're monitoring
Key metrics/signals for this service or feature, and why each one matters.

- Tie each signal to a user-facing or business outcome it's a proxy for — a metric nobody can explain the purpose of tends to get ignored when it fires.
- Cover the full stack relevant to this service: application metrics, infra metrics, and business/product metrics, not just the ones easiest to instrument.
- Note anything intentionally *not* monitored yet and why, so it's a known gap rather than an assumed one.

## Alerting
Turn the signals above into pageable thresholds — a signal without a threshold is just a chart nobody watches.

| Signal | Threshold | Severity | Who's paged |
|---|---|---|---|

- Set thresholds from actual observed behavior (a percentile, a historical baseline), not a round number picked because it sounded reasonable.
- Match severity to real urgency — over-paging on low-severity signals is what trains people to ignore pages.
- "Who's paged" should route to a rotation, not a person, unless it's genuinely a single-owner service.

## Dashboards
Links to the dashboards that give an on-call engineer situational awareness in under a minute.

- Link directly to the dashboard, filtered/scoped to this service if the platform supports it — a generic dashboard that needs manual filtering costs time during an incident.
- If there's a "start here" dashboard vs. deeper diagnostic ones, say which is which.

## Known noisy alerts
Alerts that fire without indicating a real problem, and why they haven't been fixed/removed yet — prevents alert fatigue from becoming "just ignore that one."

- For each one, note whether it's actively being fixed or accepted as permanently noisy — an unowned noisy alert is a future incident that gets ignored.
- If on-call has a standard response to a noisy alert (acknowledge and move on, silence until a fix ships), write that down here.

## Escalation
Who gets paged, and what's the path if the first responder can't resolve it?

- Name the actual secondary/escalation rotation, not just "the team" — same reasoning as a runbook's escalation section.
- State the time-to-escalate, if there's a defined SLA for the first responder before it goes further.
