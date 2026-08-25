---
title: "Release Checklist: <Service/Project Name>"
description: Execute and verify a specific release.
cadence: living
owner: <name>
updated: <date>
---

# Release Checklist: <Service/Project Name>

*Execution checklist for a specific release; see `testing/release-signoff.md` for the formal QA approval record.*

## Pre-deploy
Confirm the release is safe to start deploying before anyone touches production.

- Check items off as you actually verify them, not preemptively — a checked box should mean "confirmed," not "probably fine."
- If any item can't be checked (no feature flag needed, no migration in this release), say so explicitly ("N/A — no migrations") rather than leaving it unchecked and ambiguous.
- Add release-specific items here if this release has an unusual risk (a schema change, a dependency upgrade) that the standard list doesn't cover.

- [ ] Migrations reviewed and reversible
- [ ] Feature flags configured for intended rollout state
- [ ] Monitoring/alerting covers any new surface area
- [ ] Rollback path confirmed

## Deploy
Confirm the deploy itself completed and the service came back healthy — before declaring victory or moving to broader verification.

- Don't move to post-deploy checks until health checks are actually green, not just "the deploy command exited 0."

- [ ] Deploy steps followed (see `deployment-guide.md`)
- [ ] Health checks passing post-deploy

## Post-deploy
Confirm the release actually works in production and stakeholders know it shipped.

- Watch dashboards for a long enough window to catch delayed effects (traffic ramping, cache expiry, a batch job) — not just the first five minutes.
- "Stakeholders notified" should include whoever asked for the feature, not just the engineering channel.

- [ ] Smoke test critical paths
- [ ] Dashboards checked for anomalies over the following period
- [ ] Stakeholders notified release is live

## Rollback trigger
What observed condition would trigger an immediate rollback of this specific release.

- Define this before deploying, not while already mid-incident — deciding the threshold in the moment is exactly when bias toward "let's wait and see" creeps in.
- Make it a concrete, observable condition (an error rate above X%, a specific failing check), not a judgment call to be made under pressure.
