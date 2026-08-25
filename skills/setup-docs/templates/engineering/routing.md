---
title: "engineering/ — Template Routing"
description: Template routing for engineering docs — architecture, ADRs, API specs, data models.
category: engineering
template_count: 14
---

# engineering/ — Template Routing

Architecture, ADRs, API specs, data models, technical design. ADRs are write-once/append-only; specs and designs are living.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `adr.template.md` | Recording one architectural decision (append-only — real ADRs live at `engineering/adr/NNNN-title.md`) | Context, Decision, Alternatives considered, Consequences |
| `api-spec.template.md` | Defining or updating a living API/data contract we own | Endpoints/Interfaces, Data model, Error handling, Versioning policy |
| `architecture-overview.template.md` | Describing overall system architecture — the current-state picture | Context, Components, Data flow, Trust boundaries, Key constraints, Related ADRs |
| `data-model.template.md` | Defining entities and relationships across a system | Entities, Schema, Relationships, Lifecycle, Invariants |
| `tech-design.template.md` | Proposing a single feature's implementation approach before writing code | Problem, Proposed design, Alternatives considered, Risks & open questions, Rollout plan |
| `migration-plan.template.md` | Planning a specific database/infra migration | Scope, Steps & sequencing, Data integrity, Rollback plan, Timeline |
| `tech-debt-log.template.md` | Recording a deliberate shortcut taken during implementation | Entries (date, description, reason, cost, owner, status table) |
| `integration-spec.template.md` | Defining a third-party integration's contract (someone else's API we depend on) | Purpose, Authentication, Data exchanged, Failure handling, Rate limits & quotas, Contacts & support |
| `runtime-incident-postmortem.template.md` | Documenting a production incident caused by application code, not infra (see `operations/incident-postmortem.md` for infra-caused) | Summary, Timeline, Impact, Root cause, Why it wasn't caught, Fix, Action items |
| `data-dictionary.template.md` | Documenting fields in one specific database table/dataset | Overview, Fields, Sample values, Related tables |
| `data-contract.template.md` | Defining a producer/consumer data agreement between teams | Producer & consumers, Schema, Guarantees, Change process, Consumption expectations |
| `model-card.template.md` | Documenting a shipped ML model | Overview, Training data, Performance, Limitations, Intended use & out-of-scope use, Monitoring |
| `dataset-card.template.md` | Documenting a dataset used for ML | Overview, Provenance, Composition, Collection process, Known limitations, Related models |
| `rfc.template.md` | Proposing a larger initiative that will spawn multiple ADRs/tech-designs | Summary, Motivation, Proposed approach, Alternatives considered, Scope & phasing, Open questions, Related decisions |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **research** — market research, competitive analysis, technical spikes → `docs/research/routing.md`
2. **security** — threat models, compliance, access policies → `docs/security/routing.md`
3. **operations** — deployment, runbooks, monitoring, incident response → `docs/operations/routing.md`
4. **design** — UX flows, design system, accessibility → `docs/design/routing.md`
5. **testing** — test strategy, test plans, coverage → `docs/testing/routing.md`
6. **product** — PRDs, user stories, roadmap, personas → `docs/product/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
