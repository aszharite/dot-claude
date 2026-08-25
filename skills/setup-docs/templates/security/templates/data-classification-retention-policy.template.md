---
title: "Data Classification & Retention Policy: <Organization/System Name>"
description: Define data sensitivity tiers and how long data is kept.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Data Classification & Retention Policy: <Organization/System Name>

## Classification tiers
| Tier | Definition | Examples | Handling requirements |
|---|---|---|---|

- Keep the tier count small (3-4) — a scheme with too many tiers ends up ignored because nobody can reliably place data into the right one.
- "Examples" should be concrete data types actually present in this org (customer email, SSNs, source code, internal financials) — abstract examples don't help someone classifying real data.
- "Handling requirements" should differ meaningfully between tiers (encryption at rest, access restrictions, transmission rules) — if every tier has the same requirements, the classification isn't doing any work.

## Labeling
How data gets tagged with its classification in practice (schema field, storage location, naming convention).

- Name the actual mechanism (a database column, a folder structure, a file naming convention, a tag in the storage system) — a labeling scheme that only exists in this document and not in the system itself won't be followed.
- Cover what happens to unlabeled data by default — a policy silent on the default classification for new/unlabeled data effectively lets it default to "least protected."

## Retention schedule
| Data type | Classification | Retention period | Deletion method |
|---|---|---|---|

- Tie the retention period to an actual reason (a legal requirement, a business need, a contractual term) — a period picked arbitrarily is hard to defend to an auditor and hard to justify shortening later.
- "Deletion method" matters as much as the period — soft-delete, hard-delete, and cryptographic erasure have different guarantees, and "delete" alone doesn't say whether backups are included.

## Legal holds
How retention is overridden when data must be preserved for legal/regulatory reasons.

- Name who can invoke a hold (legal counsel, typically) and how it's communicated to whoever would otherwise delete that data on schedule — a hold that doesn't reach the system actually deleting data doesn't work.
- State how a hold is lifted and normal retention resumes — a hold with no release process becomes permanent by default.
