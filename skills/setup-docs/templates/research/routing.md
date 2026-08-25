---
title: "research/ — Template Routing"
description: Template routing for research docs — market research, competitive analysis, technical spikes.
category: research
template_count: 7
---

# research/ — Template Routing

Market research, competitive analysis, technical spikes. Write-once, archival — a follow-up gets a new dated file, never an edit to an old one.

## Templates

| Template | Use when... | Key sections |
|---|---|---|
| `spike.template.md` | Investigating a technical or product question before it feeds a PRD or ADR | Question, Method, Findings, Implications |
| `competitive-analysis.template.md` | Understanding the competitive landscape for a market or product area | Scope, Competitors evaluated, Feature comparison, Differentiation opportunities, Risks & threats, Sources |
| `market-analysis.template.md` | Sizing a market opportunity (TAM/SAM/SOM) before committing resources | Market definition, Size & growth, Trends, Target segment, Competitive landscape, Opportunity & risks, Methodology caveats |
| `user-research.template.md` | Synthesizing findings from interviews, usability tests, or other qualitative research, after it's conducted | Research question, Method, Participants, Findings, Implications, Follow-up questions |
| `experiment-report.template.md` | Recording the outcome of an A/B test or experiment | Hypothesis, Setup, Results, Conclusion, Caveats |
| `prior-art.template.md` | Surveying how others have solved a technical problem before a build-vs-adopt decision | Problem, Existing solutions surveyed, Build vs. adopt, Implications |
| `interview-guide.template.md` | Preparing a question set before conducting user interviews | Research goal, Screener criteria, Warm-up questions, Core questions, Wrap-up, Logistics |

## Not finding a fit?

None of the templates above match what you're about to write? Check the other 6 categories below, in order, and stop at the first template that actually fits — don't force a mismatch.

1. **security** — threat models, compliance, access policies → `docs/security/routing.md`
2. **engineering** — architecture, ADRs, API specs, data models, technical design → `docs/engineering/routing.md`
3. **operations** — deployment, runbooks, monitoring, incident response → `docs/operations/routing.md`
4. **design** — UX flows, design system, accessibility → `docs/design/routing.md`
5. **testing** — test strategy, test plans, coverage → `docs/testing/routing.md`
6. **product** — PRDs, user stories, roadmap, personas → `docs/product/routing.md`

Still nothing after checking all 7? Don't force a mismatched template — write the doc ad-hoc in whichever category is the closest fit, and note the gap; it may be worth proposing a new template.
