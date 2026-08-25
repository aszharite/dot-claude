---
title: "Security Incident Postmortem: <Incident Title>"
description: Document a security breach or exploit after the fact.
cadence: write-once
author: <name>
date: <date>
severity: <SEV1-4>
status: Draft  # or: Final
---

# Security Incident Postmortem: <Incident Title>

*Blameless — this document explains systems and process, not people. Coordinate with legal/compliance before external distribution.*

## Summary
What happened, in two or three sentences.

- Write this last, even though it reads first — it should be the plain-language version a non-technical exec or customer-facing team could read start to finish.
- Avoid minimizing or hedging language ("a minor issue occurred") — the summary sets the tone for how seriously the rest of the document, and any response, gets taken.

## Timeline
| Time (UTC) | Event |
|---|---|

- Use a single timezone throughout (UTC, as shown) — a timeline mixing timezones across a multi-region incident is a common source of confusion during and after the response.
- Include the boring-but-critical timestamps, not just the dramatic ones: when the vulnerability was likely introduced, when it was first exploited (if knowable), when it was detected, and when each containment step landed.

## Scope & impact
What systems/data were affected, and how was that determined? Include what data was potentially exposed, and to whom.

- Distinguish confirmed impact from suspected/possible impact — conflating the two either understates the real exposure or triggers overbroad notification; both have real costs.
- State the method used to determine scope (log analysis, forensic review, vendor confirmation) — a scope claim with no stated method is hard for legal/compliance to rely on when deciding notification obligations.

## Root cause
The technical/process vulnerability that was exploited or failed.

- Go past the immediate technical bug to the process gap that let it reach production or stay undetected (missing review step, no automated scanning, an untested rollback) — fixing only the code-level bug leaves the systemic weakness in place for the next incident.
- Keep this blameless and specific to systems and process, per this doc's framing — "an engineer made a mistake" isn't a root cause; "the deploy process had no required review for this change type" is.

## Detection & response
How was this detected, how long until containment, and did the incident-response-plan work as intended?

- State the actual detection-to-containment duration as a number, not a description — this is the metric that most directly measures whether the response worked.
- Call out specifically where the `incident-response-plan.md` worked and where it didn't (a role that wasn't staffed, a trigger that fired too late) — this section is what makes the standing plan improve after each real incident.

## Notification
Who was notified (customers, regulators, partners), when, and under what legal/contractual obligation.

- Name the specific obligation driving each notification (a regulation's timeline, a contract's breach clause) — a notification made "to be safe" with no stated basis is harder for legal to defend or scope consistently next time.
- Record actual notification timestamps against any legal deadline (e.g. GDPR's 72-hour window) — this is the record that proves the obligation was met, not just that it eventually happened.

## Forensics
Evidence preserved, chain of custody, and findings from any forensic investigation.

- Document what evidence was preserved and how (snapshots, log exports, disk images) before systems were remediated or rebuilt — evidence collected after cleanup is far weaker, and remediation often happens fast under pressure.
- Note chain of custody if this incident could lead to legal action or law enforcement involvement — evidence without documented custody can be challenged later.

## Action items
| Action | Owner | Due date | Status |
|---|---|---|---|

- Write action items as systemic fixes (add a scanning step, change an approval gate), not just "patch the specific bug" — the specific bug is usually already fixed by the time this document is written.
- Give every item a real owner and date — an incident postmortem with unowned action items is where organizations relearn the same lesson repeatedly.

## Related
Link to the `vulnerability-assessment.md` or `threat-model.md` this incident should update.

- If this incident reveals a gap the threat model didn't anticipate, that model needs an actual update, not just a mention here — link forward so the update happens.
- If a prior vulnerability assessment should have caught this, note that too — it's a signal about the assessment's methodology, not just about this one incident.
