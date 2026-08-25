---
title: "security/ — Template Routing"
description: Template routing for security docs — threat models, compliance, access policies.
category: security
template_count: 14
---

# security/ — Template Routing

Threat models, compliance requirements, access policies. Regulatory-driven, periodic review.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `threat-model.template.md` | Assessing threats to a specific feature or system | Assets & trust boundaries, Threats (STRIDE-style table), Compliance, Access policy |
| `compliance-checklist.template.md` | Mapping a regulatory framework's requirements to actual controls | Scope, Requirements (requirement → control → evidence → status), Gaps, Last review |
| `access-policy.template.md` | Defining who can access a specific system or resource | Scope, Roles & permissions, Provisioning & deprovisioning, Review process, Exceptions |
| `security-review.template.md` | Gating a specific feature/change before it ships | Scope, Data handled, Threats considered, Findings, Sign-off |
| `information-security-policy.template.md` | Stating the org's overall security approach — the cornerstone doc other policies point back to | Purpose & scope, Principles, Roles & responsibilities, Policy references, Exceptions |
| `acceptable-use-policy.template.md` | Defining rules for how people use systems/devices/accounts | Scope, Permitted use, Prohibited use, Device & account requirements, Enforcement |
| `change-management-policy.template.md` | Governing how a change reaches production, at the process level | Scope, Change process, Approval requirements, Emergency changes, Communication |
| `vendor-management-policy.template.md` | Governing third-party/vendor risk | Scope, Selection & onboarding, Ongoing monitoring, Offboarding, Incidents |
| `data-classification-retention-policy.template.md` | Defining data sensitivity tiers and how long data is kept | Classification tiers, Labeling, Retention schedule, Legal holds |
| `risk-assessment.template.md` | Periodically assessing organizational risk | Scope, Identified risks, Mitigation plan, Accepted risks, Next review |
| `logging-monitoring-policy.template.md` | Defining what gets logged/retained for audit purposes (not per-service alerting — see `operations/monitoring-plan.md`) | Scope, Events logged, Log handling, Retention, Review |
| `incident-response-plan.template.md` | Defining the standing process for how the org responds to any incident | Detection, Categorization, Response team & roles, Escalation timeframes, Communication, Post-incident |
| `vulnerability-assessment.template.md` | Recording pentest/vulnerability scan results | Scope, Methodology, Findings, Remediation plan, Retest |
| `security-incident-postmortem.template.md` | Documenting a security breach/exploit after the fact (not a generic outage — see `operations/incident-postmortem.md`) | Summary, Timeline, Scope & impact, Root cause, Detection & response, Notification, Forensics, Action items |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **research** — market research, competitive analysis, technical spikes → `docs/research/routing.md`
2. **engineering** — architecture, ADRs, API specs, data models, technical design → `docs/engineering/routing.md`
3. **operations** — deployment, runbooks, monitoring, incident response → `docs/operations/routing.md`
4. **design** — UX flows, design system, accessibility → `docs/design/routing.md`
5. **testing** — test strategy, test plans, coverage → `docs/testing/routing.md`
6. **product** — PRDs, user stories, roadmap, personas → `docs/product/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
