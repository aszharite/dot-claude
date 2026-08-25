---
title: "Vendor Management Policy: <Organization Name>"
description: Govern third-party and vendor risk.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Vendor Management Policy: <Organization Name>

## Scope
What counts as a vendor/third party under this policy (SaaS tools, contractors, data processors, subprocessors).

- Include the categories people forget: free-tier SaaS tools an individual signs up for, open-source dependencies with paid support, and subprocessors your own vendors use — shadow IT is where most uncontrolled vendor risk actually lives.
- State the threshold for when a tool needs this process at all — not every internal utility needs a full vendor review, but the line should be explicit, not a judgment call by whoever's signing up.

## Selection & onboarding
Risk assessment steps required before a new vendor is approved (security review, data handling, contractual terms).

- Tie the depth of review to what data/access the vendor will touch — a vendor with no data access needs a lighter review than one processing customer PII.
- Name the actual contractual terms required (a DPA, a breach notification clause, subprocessor disclosure) — "review the contract" without naming what to check for lets risky terms through unnoticed.

## Ongoing monitoring
| Vendor | Data/access granted | Risk tier | Last reviewed |
|---|---|---|---|

- "Data/access granted" should reflect what's actually integrated today, not what was approved at onboarding — vendor access tends to expand quietly as integrations deepen.
- Risk tier determines review cadence — high-tier vendors handling regulated data need more frequent re-review than a low-risk internal tool, and the table should make that visible at a glance.
- A vendor with a stale "last reviewed" date relative to its tier is the finding an auditor looks for first.

## Offboarding
How vendor access and data are revoked/returned when a relationship ends.

- Cover both directions: revoking the vendor's access to your systems, and getting your data back from or confirming deletion by the vendor.
- Set a deadline for confirming data deletion/return, not just initiating the offboarding — an offboarding process with no confirmation step leaves data at a vendor indefinitely.

## Incidents
How a vendor-caused incident is handled and disclosed.

- State who owns communication when the incident originates at the vendor, not internally — this is easy to fall through the cracks between "it's their bug" and "it's our data."
- Reference contractual notification obligations (the vendor's duty to notify you, and yours to notify customers/regulators) — the timelines on each side are rarely the same.
