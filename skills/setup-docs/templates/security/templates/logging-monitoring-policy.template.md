---
title: "Logging & Monitoring Policy: <System/Organization Name>"
description: Define what gets logged and retained for audit purposes.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Logging & Monitoring Policy: <System/Organization Name>

*Distinct from `operations/monitoring-plan.md` — this is the compliance/audit policy for what gets logged and retained, not the per-service alerting setup.*

## Scope
What systems/events this policy covers.

- Name the systems this applies to explicitly — a policy that's silent on a particular system (a third-party SaaS tool, a legacy service) leaves that system's logging requirements undefined by default.
- Distinguish this from `operations/monitoring-plan.md`: that covers alerting for a specific service; this covers what's captured and retained for audit/compliance purposes across the org.

## Events logged
What activity/event data is captured (auth events, admin actions, data access, config changes).

- Name the specific event categories a compliance framework or incident investigation would need (successful/failed auth, privilege changes, access to regulated data, config/infra changes) — "we log a lot" doesn't tell an auditor or an incident responder what they can actually find.
- Say what's explicitly *not* logged and why (e.g. request bodies containing PII are excluded) — an omission that's a deliberate privacy choice looks identical to a gap unless it's stated.

## Log handling
Where logs are stored, who can access them, and how they're protected from tampering.

- Access to logs should itself be restricted and auditable — logs that anyone can edit or delete aren't reliable evidence during an investigation.
- Name the tamper-protection mechanism (write-once storage, checksums, a separate logging system from the one being monitored) — logs stored on the same system they're monitoring can be altered by whoever compromises that system.

## Retention
How long logs are kept, and why (compliance requirement, operational need).

- Tie the retention period to the reason driving it (a specific regulation, a contractual SLA, incident-investigation windows) — a retention period with no stated reason is the first thing to get shortened when storage costs come up.
- Note if different log types have different retention needs (auth logs often need longer retention than debug logs) rather than applying one blanket period.

## Review
Who reviews logs, how often, and what triggers escalation.

- Name what "review" actually means — a person scanning a dashboard periodically vs. automated alerting on specific patterns are very different levels of rigor, and this section should say which.
- Define concrete escalation triggers (a spike in failed auth, an admin action outside business hours) — a review process with no defined trigger relies entirely on the reviewer noticing something unusual by chance.
