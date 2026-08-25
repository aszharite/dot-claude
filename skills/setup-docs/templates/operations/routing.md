---
title: "operations/ — Template Routing"
description: Template routing for operations docs — deployment, runbooks, monitoring, incident response.
category: operations
template_count: 11
---

# operations/ — Template Routing

Deployment guides, runbooks, monitoring/alerting, incident response. Post-launch, operational — different audience (on-call) than the build agent.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `runbook.template.md` | Giving on-call engineers a per-service quick-reference for deploy/rollback and common incidents | Deployment/rollback, Monitoring & alerting, Common incidents (symptom → cause → response), Escalation |
| `deployment-guide.template.md` | Documenting the calm, planned steps to ship a service | Prerequisites, Deploy steps, Verification, Rollback, Configuration & secrets |
| `incident-postmortem.template.md` | Documenting a generic/infra-caused production incident (see `engineering/runtime-incident-postmortem.md` for code-caused, `security/security-incident-postmortem.md` for breaches) | Summary, Timeline, Impact, Root cause, What went well, What went wrong, Action items |
| `monitoring-plan.template.md` | Defining what to monitor/alert on for a specific service or feature | What we're monitoring, Alerting, Dashboards, Known noisy alerts, Escalation |
| `capacity-planning.template.md` | Planning for scale before it becomes an incident | Current capacity, Growth forecast, Scaling thresholds, Scaling approach, Lead time |
| `slo-definitions.template.md` | Defining reliability targets for a service | SLIs, SLOs, Error budget, Consequences |
| `on-call-handbook.template.md` | Onboarding a new on-call engineer to the team/rotation | Rotation, Getting access, Escalation paths, Expectations, First 15 minutes |
| `dependency-map.template.md` | Documenting what a service depends on, for blast-radius awareness | Upstream dependencies, Downstream dependents, Blast radius, Single points of failure |
| `production-readiness-review.template.md` | Gating a service's *first* launch (not a recurring release — see `release-checklist.template.md`) | Scope, Monitoring & alerting, On-call readiness, Rollback, Dependencies, Sign-off |
| `disaster-recovery-plan.template.md` | Planning recovery from a major failure/disaster | Scope, Recovery objectives (RTO/RPO), Backup strategy, Recovery steps, Communication plan, Last tested |
| `release-checklist.template.md` | Executing and verifying a specific release (pairs with `testing/release-signoff.md`'s formal QA approval) | Pre-deploy / Deploy / Post-deploy checklists, Rollback trigger |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **research** — market research, competitive analysis, technical spikes → `docs/research/routing.md`
2. **security** — threat models, compliance, access policies → `docs/security/routing.md`
3. **engineering** — architecture, ADRs, API specs, data models, technical design → `docs/engineering/routing.md`
4. **design** — UX flows, design system, accessibility → `docs/design/routing.md`
5. **testing** — test strategy, test plans, coverage → `docs/testing/routing.md`
6. **product** — PRDs, user stories, roadmap, personas → `docs/product/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
