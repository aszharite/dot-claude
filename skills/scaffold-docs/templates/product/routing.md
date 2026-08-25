---
title: "product/ — Template Routing"
description: Template routing for product docs — PRDs, user stories, roadmap, personas.
category: product
template_count: 11
---

# product/ — Template Routing

PRDs, user stories, roadmap, personas, success metrics. Living, updated every cycle.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `prd.template.md` | Defining what to build and why | Problem, Goals & Non-Goals, Users & Use Cases, Requirements (numbered), Success Metrics, Open Questions |
| `user-story.template.md` | Describing one deliverable slice from the user's perspective | Story (As a/I want/so that), Acceptance criteria, Out of scope, Notes |
| `roadmap.template.md` | Showing sequencing/priority of what's being built over time | Now, Next, Later, Explicitly not planned, Changelog |
| `persona.template.md` | Representing a user archetype grounded in research | Summary, Goals, Pain points, Context & behavior, Representative quote, Evidence |
| `release-notes.template.md` | Communicating what shipped, to users (the only product template written for customers, not planning) | Highlights, New features, Improvements, Bug fixes, Known issues |
| `okr.template.md` | Setting and tracking measurable goals for a period | Objectives with key-result tables, Alignment, Retro |
| `product-vision.template.md` | Stating the long-term "why" behind the product — rarely changes | Vision statement, Who it's for, Why now, What success looks like, What this is not |
| `one-pager.template.md` | Pitching an opportunity before the solution is clear enough for a full PRD | Opportunity, Hypotheses, Possible approaches, What we'd need to learn, Recommendation |
| `go-to-market-plan.template.md` | Planning a launch across marketing/sales/support | Positioning, Target audience, Messaging, Channels & timeline, Success metrics, Cross-team dependencies |
| `decision-log.template.md` | Tracking a non-architectural product decision (pricing, positioning, prioritization) | Decisions table (date, decision, options considered, rationale, owner) |
| `prfaq.template.md` | Validating a product idea before committing resources — Amazon-style "working backwards" | Press release, FAQ — customer questions, FAQ — internal questions, Decision |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **research** — market research, competitive analysis, technical spikes → `docs/research/routing.md`
2. **security** — threat models, compliance, access policies → `docs/security/routing.md`
3. **engineering** — architecture, ADRs, API specs, data models, technical design → `docs/engineering/routing.md`
4. **operations** — deployment, runbooks, monitoring, incident response → `docs/operations/routing.md`
5. **design** — UX flows, design system, accessibility → `docs/design/routing.md`
6. **testing** — test strategy, test plans, coverage → `docs/testing/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
