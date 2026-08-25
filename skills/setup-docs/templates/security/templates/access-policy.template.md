---
title: "Access Policy: <System/Resource Name>"
description: Define who can access a specific system or resource.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. quarterly>
---

# Access Policy: <System/Resource Name>

## Scope
What system, data, or resource does this policy govern?

- Name the specific system/resource, not "our infrastructure" — a policy that's too broad ends up enforced nowhere in particular.
- State what's explicitly out of scope, especially adjacent systems people might assume are covered (e.g. a data-access policy that doesn't cover the analytics warehouse copy of that data).

## Roles & permissions
| Role | Access granted | Justification |
|---|---|---|

- "Access granted" should be specific enough to audit against (read/write/admin on which resource), not "full access" — vague grants are how privilege creep gets started.
- "Justification" ties the grant to a job function, not a person — access should map to a role, so it survives personnel changes without becoming stale.
- List roles by function (e.g. "on-call engineer," "billing admin"), not by individual name — named-person rows are the first thing that breaks when that person leaves.

## Provisioning & deprovisioning
How is access granted (approval flow) and revoked (offboarding, role change)?

- Name who approves each grant and what evidence they need (manager sign-off, ticket, a role change in the HR system) — an approval flow with no named approver isn't really enforced.
- State the deprovisioning trigger explicitly (termination, role change, project end) and the SLA for revoking access after it fires — access that lingers after someone leaves is one of the most common audit findings.
- Cover role changes, not just departures — someone moving teams keeps old access far more often than someone who leaves outright.

## Review process
How often is access reviewed, and by whom, to catch privilege creep?

- Name a cadence and an actual reviewer (a manager, a system owner), not "periodically" — a review with no owner doesn't happen.
- Define what "reviewed" means in practice: does the reviewer see a list of current grants and have to actively re-approve each one, or just get notified? Passive review catches almost nothing.

## Exceptions
Any standing exceptions to the policy above, who approved them, and when they expire.

- Every exception needs an expiry, even a far one — an exception with no end date is a permanent hole in the policy.
- Record who approved it and why — an exception granted "temporarily" during an incident and never revisited is how policies quietly stop meaning anything.
