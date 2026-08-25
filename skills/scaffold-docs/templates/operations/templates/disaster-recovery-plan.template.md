---
title: "Disaster Recovery Plan: <System/Service Name>"
description: Plan recovery from a major failure or disaster.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Disaster Recovery Plan: <System/Service Name>

*Tested via: <e.g. annual DR drill>.*

## Scope
What system(s)/data this plan covers, and the disaster scenarios considered (region outage, data corruption, provider failure).

- Be explicit about which scenarios are in scope and which are out — a plan that silently assumes "disaster" means only one specific failure mode will fail to cover the one that actually happens.
- State what's explicitly out of scope, too (e.g. this plan doesn't cover a company-wide office outage) so nobody expects it to.

## Recovery objectives
The recovery time and data-loss targets this plan commits to — set these before designing the backup strategy, not after.

| System | RTO (time to recover) | RPO (acceptable data loss) |
|---|---|---|

- RTO and RPO should come from what the business actually needs (how much downtime/data loss is tolerable), not from what the current backup setup happens to already achieve.
- If different systems within scope have very different objectives (a database needing near-zero RPO vs. an analytics store that can tolerate a day), give each its own row rather than one blended number.

## Backup strategy
What's backed up, how often, where, and how backup integrity is verified.

- State backup frequency in terms that map directly to the RPO above — a daily backup can't support an RPO of one hour.
- "Where" should include geographic/provider separation from the primary system — a backup stored in the same region/account as the original doesn't protect against a regional or account-level disaster.
- Describe how integrity is verified (periodic restore tests, checksums) — an unverified backup is a hypothesis, not a guarantee.

## Recovery steps
Ordered steps to restore service from backup, including who executes each step.

- Write these as steps someone could follow under stress, at 3am, possibly without the usual team available — this is not the place for shorthand only the author understands.
- Note dependencies between steps (which must happen before which) and any steps that can run in parallel to shorten actual recovery time.

## Communication plan
Who needs to be notified during a disaster recovery event, internally and externally.

- Include customer/external communication, not just internal escalation — a prolonged outage usually needs a status-page update or customer notice, and that shouldn't be improvised mid-crisis.
- Name who's authorized to send external communications, since that's often a different person than whoever is executing recovery steps.

## Last tested
Date of the last DR drill, what was validated, and what gaps it surfaced.

- Record the actual gaps found, even embarrassing ones — a drill that surfaces nothing wrong is more likely under-testing than a perfect plan.
- If a gap was found, note whether it's been fixed yet or is still open — an unresolved gap from the last drill is exactly what the next drill (or the next real disaster) will re-discover.
