---
title: "Deployment Guide: <Service/Project Name>"
description: Document the calm, planned steps to ship a service.
cadence: living
owner: <name>
updated: <date>
---

# Deployment Guide: <Service/Project Name>

## Prerequisites
Access, credentials, tooling needed before deploying.

- List concrete access requirements (repo permissions, cloud console roles, VPN) and where to request them — not just "prod access."
- Note any tooling versions or local setup that must match exactly, if a mismatch has caused a bad deploy before.
- If prerequisites differ between environments (staging vs. prod), say so explicitly.

## Deploy steps
Ordered, copy-pasteable steps — someone unfamiliar with this service should be able to follow them without guessing.

- Write each step as a literal command or click-path, not a description of intent ("run the deploy script" beats "deploy the service").
- Call out any step that's irreversible or order-dependent before it happens, not after.
- If a step normally takes a while (build, migration, cache warm), note the expected duration so no one aborts a step that's just slow.

1.
2.

## Verification
How do you confirm the deploy succeeded (health checks, smoke tests, dashboards to watch)?

- Give a concrete pass/fail signal, not "check that it looks fine" — a specific endpoint, exit code, or metric.
- Include how long to watch before declaring success; some regressions only show up after real traffic hits the new version.
- If verification requires comparing against a baseline (error rate, latency), say what the baseline is.

## Rollback
Exact steps to revert if the deploy is bad — this section is the one people need most under pressure, so keep it concrete and copy-pasteable.

- Test this procedure at least once outside of an actual incident — a rollback step that's never been run is a guess, not a plan.
- State what rollback does *not* undo (e.g. a migration that already ran) so responders aren't surprised mid-recovery.
- Include the command/button to trigger rollback directly here, even if it's also in a deploy tool — don't make responders navigate elsewhere under pressure.

## Configuration & secrets
Where config/secrets live and how they're managed per environment — never inline actual secret values here.

- Link to the secrets manager/vault and who has access to rotate or view values, not the values themselves.
- Note which config differs between environments, since a config diff is a common cause of "works in staging, breaks in prod."
- If a secret rotation requires a coordinated deploy or restart, say so.
