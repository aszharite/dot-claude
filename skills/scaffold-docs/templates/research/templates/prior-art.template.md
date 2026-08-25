---
title: "Prior Art: <Problem/Capability>"
description: Survey how others have solved a technical problem before a build-vs-adopt decision.
cadence: write-once
author: <name>
date: <date>
---

# Prior Art: <Problem/Capability>

## Problem
What are we trying to solve, in enough detail that "how others solved this" is a meaningful comparison?

- Describe the problem in terms of constraints (scale, latency, compliance, team size) that actually differentiate solutions — a vague problem statement makes every existing solution look equally plausible.
- Note any constraints specific to your context (existing stack, team expertise, budget) that will shape which of the surveyed solutions is realistic to adopt.

## Existing solutions surveyed
| Solution | Approach | Strengths | Weaknesses |
|---|---|---|---|

- Include solutions genuinely relevant to the constraints above, not every tool that touches the space — a long table of loosely-related options is harder to act on than a short table of close comparisons.
- "Approach" should capture the underlying technique or architecture, not just the product name — that's what lets you compare solutions that use different terminology for similar ideas.
- Weaknesses should be specific to your problem's constraints (e.g. "doesn't support our scale," "requires a dependency we can't take on"), not generic criticism of the tool.

## Build vs. adopt
What's the recommendation, and why — build custom, adopt/integrate an existing solution, or fork one?

- State the recommendation plainly before the reasoning — a reader deciding whether to read further wants the answer first.
- Weigh the real cost of building (ongoing maintenance, not just initial implementation) against the real cost of adopting (integration effort, vendor risk, license terms, fit gaps) — both sides are usually underestimated in opposite directions.

*If the honest answer is "adopt, with caveats," say so — a forced build-vs-adopt binary hides the more common outcome of adopt-and-patch-the-gaps.*

## Implications
What should this change about the approach we take? Link to the ADR or tech-design this feeds into.

- Connect the recommendation directly to the decision it's meant to unblock — this section exists to hand the answer to whoever writes the ADR or tech-design next.
- This survey reflects what was available and how it compared at the date above — tooling in this space moves fast, so a stale prior-art doc should be re-surveyed, not assumed still accurate.
