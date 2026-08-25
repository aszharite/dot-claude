---
title: "Incident Response Plan: <Organization/System Name>"
description: Define the standing process for how the org responds to any incident.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Incident Response Plan: <Organization/System Name>

*The process this org follows during any incident; see a postmortem template for a specific incident's record.*

## Detection
How incidents get identified and reported (monitoring alerts, user reports, external disclosure).

- Cover every realistic detection path, not just automated monitoring — a security researcher's disclosure email or a customer support ticket are common first signals, and each needs a known intake path.
- Name where a report goes on arrival (an on-call rotation, a dedicated inbox, a specific person) — a detection path that dead-ends at "someone will notice eventually" delays response.

## Categorization
Severity levels and what defines each.

- Define each severity level by concrete criteria (data exposed, systems affected, active exploitation vs. theoretical) — a severity scale left to judgment gets inconsistently applied under the pressure of an actual incident.
- Keep the number of levels small enough that responders can categorize quickly in the moment — a scale that requires deliberation to apply defeats its own purpose during a live incident.

## Response team & roles
Who's on the response team, and what does each role own during an incident.

- Name roles (incident commander, communications lead, technical lead), not just a list of people — roles survive personnel changes and clarify who decides what when multiple people are involved.
- State who has the authority to declare an incident and invoke this plan — an incident response plan nobody's empowered to trigger doesn't get used when it matters.

## Escalation timeframes
| Severity | Initial response | Escalation trigger | Who's notified |
|---|---|---|---|

- Tie response times to severity concretely (e.g. SEV1 acknowledged within 15 minutes) — a timeframe not tied to severity either over-responds to minor issues or under-responds to critical ones.
- "Escalation trigger" should be a concrete condition (time elapsed without containment, scope grows), not "if it seems bad" — vague triggers mean escalation happens late, by which point damage has compounded.

## Communication
Internal updates cadence, and external/customer/regulatory notification requirements and timing.

- Separate internal status updates (cadence, audience) from external/regulatory notification (which often has legally mandated timelines, e.g. 72 hours under GDPR) — conflating the two risks missing a hard legal deadline while over-communicating internally.
- Name who's authorized to speak externally — uncoordinated external communication during an active incident is itself a common source of legal and reputational harm.

## Post-incident
Once resolved, record what actually happened in the appropriate postmortem template.

- Link explicitly to `security-incident-postmortem.md` — this plan describes the standing process, not what happened in any one incident.
- Note that this step applies even to near-misses and incidents that didn't require external notification — the plan improves fastest when every incident, not just the severe ones, feeds back into it.
