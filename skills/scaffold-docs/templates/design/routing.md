---
title: "design/ — Template Routing"
description: Template routing for design docs — UX flows, design system, accessibility.
category: design
template_count: 9
---

# design/ — Template Routing

UX flows, wireframes, design system refs, accessibility notes. Iterates with product, semi-independent.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `flow-spec.template.md` | Defining one UX flow (e.g. "checkout," "onboarding") | Entry points, Steps, Edge cases & empty/error states, Accessibility notes, Design references |
| `design-system.template.md` | Documenting the design system as a whole — colors, typography, components, patterns | Foundations, Components, Patterns, Deviations |
| `accessibility-audit.template.md` | Auditing a surface/flow for accessibility issues (dev-facing, informal — see `accessibility-conformance-report.template.md` for formal) | Scope, Findings, Keyboard navigation, Screen reader, Color & contrast, Remediation plan |
| `component-spec.template.md` | Deep-diving on a single reusable component, beyond what design-system.md's summary table covers | Purpose, Variants, States, Anatomy, Accessibility, Known limitations |
| `content-style-guide.template.md` | Defining UI copy/voice/tone rules (words, not visuals) | Voice & tone, Terminology, Formatting conventions, Writing patterns |
| `journey-map.template.md` | Mapping a user's end-to-end experience across multiple touchpoints/flows | Scope, Stages, Pain points, Opportunities, Related flows |
| `design-review-checklist.template.md` | Verifying a design is ready for engineering handoff | Scope, Checklist (responsive/states/a11y/copy/edge-cases), Open issues |
| `sitemap.template.md` | Documenting information architecture/navigation structure | Structure, Navigation, Access & permissions, Orphaned or deprecated pages |
| `accessibility-conformance-report.template.md` | Producing a formal VPAT/ACR compliance report for procurement/legal | Scope, Conformance summary, Criterion-by-criterion results, Known issues, Contact |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **research** — market research, competitive analysis, technical spikes → `docs/research/routing.md`
2. **security** — threat models, compliance, access policies → `docs/security/routing.md`
3. **engineering** — architecture, ADRs, API specs, data models, technical design → `docs/engineering/routing.md`
4. **operations** — deployment, runbooks, monitoring, incident response → `docs/operations/routing.md`
5. **testing** — test strategy, test plans, coverage → `docs/testing/routing.md`
6. **product** — PRDs, user stories, roadmap, personas → `docs/product/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
