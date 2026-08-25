---
title: "testing/ — Template Routing"
description: Template routing for testing docs — test strategy, test plans, coverage.
category: testing
template_count: 9
---

# testing/ — Template Routing

Test strategy, test plans, coverage criteria. Updated per feature/release — don't let this lag behind engineering.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `test-plan.template.md` | Planning testing for one feature/release | Scope, Test strategy (unit/integration/e2e/manual), Acceptance criteria, Coverage gaps |
| `test-strategy.template.md` | Defining the cross-project testing approach — org-wide, not per-feature | Testing pyramid, Tooling, Coverage targets, Environments, Ownership |
| `bug-report.template.md` | Reporting one specific defect | Summary, Steps to reproduce, Expected/Actual behavior, Environment, Impact, Root cause |
| `traceability-matrix.template.md` | Verifying every requirement has test coverage, project-wide | Matrix (requirement → test case → status), Coverage gaps, Notes |
| `test-summary-report.template.md` | Communicating testing results to stakeholders | Summary, Results by area, Defects found, Coverage, Recommendation |
| `regression-checklist.template.md` | Manually verifying nothing broke before a release | Core flows to verify, Environment, Sign-off |
| `performance-test-plan.template.md` | Planning load/stress testing | Objective, Load scenarios, Pass/fail criteria, Environment, Results |
| `release-signoff.template.md` | Formally approving a release from QA — go/no-go (pairs with `operations/release-checklist.md`'s execution steps) | Scope, Test results, Open defects, Risk assessment, Sign-off |
| `test-data-spec.template.md` | Documenting test data/config to prevent false failures | Data required, Environment configuration, Setup, Known constraints |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **research** — market research, competitive analysis, technical spikes → `docs/research/routing.md`
2. **security** — threat models, compliance, access policies → `docs/security/routing.md`
3. **engineering** — architecture, ADRs, API specs, data models, technical design → `docs/engineering/routing.md`
4. **operations** — deployment, runbooks, monitoring, incident response → `docs/operations/routing.md`
5. **design** — UX flows, design system, accessibility → `docs/design/routing.md`
6. **product** — PRDs, user stories, roadmap, personas → `docs/product/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
