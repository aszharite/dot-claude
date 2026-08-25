---
title: "Risk Assessment: <Scope — System/Organization/Period>"
description: Periodically assess organizational risk.
cadence: write-once
author: <name>
date: <date>
review_cadence: <e.g. quarterly/annually>
---

# Risk Assessment: <Scope — System/Organization/Period>

## Scope
What's being assessed, and what's out of scope.

- Name the actual boundary (a system, a business unit, a time period) — an assessment scoped to "the company" tends to produce risks too generic to act on.
- State what's explicitly excluded and why (assessed elsewhere, out of scope for this cycle) — so a missing risk category reads as a deliberate choice, not an oversight.

## Identified risks
| Risk | Likelihood | Impact | Risk level | Existing mitigation |
|---|---|---|---|---|

- Write each risk as a specific scenario ("a leaked API key grants write access to the production database"), not a category ("credential security") — specific risks are the ones you can actually size and mitigate.
- Use a consistent likelihood/impact scale across assessments (e.g. the same 1-5 scale each cycle) so "risk level" is comparable over time, not re-invented each review.
- "Existing mitigation" should list what's actually in place today, separate from what's planned — conflating the two makes the residual risk look smaller than it is.

## Mitigation plan
| Risk | Planned mitigation | Owner | Target date |
|---|---|---|---|

- Every risk above the org's risk-acceptance threshold should have a row here — a high risk with no mitigation plan and no entry in "accepted risks" has simply fallen through the cracks.
- Give each mitigation a real owner and date, the same as any other action-item table — an unowned mitigation plan is a wish list.

## Accepted risks
Risks knowingly left unmitigated, who accepted them, and why.

- Record who has the authority to accept this specific risk (often tied to severity — a low risk might be accepted by a team lead, a high risk needs an executive) — an "accepted" risk with no named accepter is really just an ignored one.
- Include the reasoning (cost of mitigation exceeds impact, a compensating control exists elsewhere) — a bare acceptance with no rationale can't be re-evaluated intelligently next cycle.

## Next review
When this assessment is due to be redone.

- Set a specific date or trigger (a fixed cadence, or an event like a major architecture change), not "periodically" — an assessment with no next-review date tends to become the org's risk posture indefinitely.
