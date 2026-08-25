---
title: "Postmortem: <Incident Title>"
description: Document a generic or infrastructure-caused production incident.
cadence: write-once
author: <name>
date: <date>
severity: <SEV1-4>
status: Draft  # or: Final
---

# Postmortem: <Incident Title>

*Blameless — this document explains systems and process, not people.*

## Summary
What happened, in two or three sentences.

- Someone should be able to read only this section and know what broke, for how long, and roughly why — write it last, after the rest of the doc is filled in.
- Avoid jargon or internal shorthand that won't make sense to someone outside the team reading this months later.

## Timeline
Reconstruct the sequence of events in UTC, from first cause to full resolution.

| Time (UTC) | Event |
|---|---|

- Include when the problem *started*, not just when it was detected — the gap between the two is often itself an actionable finding.
- Log detection, escalation, mitigation, and resolution as distinct events, even if some happened minutes apart.
- Pull timestamps from logs/alerts/chat history rather than memory — memory compresses and reorders under stress.

## Impact
Who/what was affected, for how long, and how was that measured (error rate, downtime, requests failed)?

- Quantify impact with a real number pulled from monitoring, not an estimate — "about 5 minutes" invites dispute later; "14:02–14:09, 3.2% error rate" doesn't.
- Include customer-facing impact separately from internal impact — a postmortem that only covers what engineers saw will undersell the incident to everyone else reading it.
- Note any downstream effects (SLA breaches, other teams' incidents triggered by this one).

## Root cause
What actually caused this — the technical/process cause, not "human error."

- Push past the first answer — "someone deployed a bad config" is a trigger, not a root cause; ask why the bad config was deployable at all.
- Distinguish the triggering event from the contributing conditions that let it cause an incident (missing validation, no canary, an alert that was silenced).
- If there were multiple contributing causes, list all of them — a postmortem that names only one cause tends to produce only one fix.

## What went well
What limited the blast radius or sped up detection/recovery?

- Be specific about *why* it helped — "the alert fired quickly" is more useful than "monitoring was good."
- Include things that could be reinforced or replicated elsewhere, not just praise.

## What went wrong
What made this worse or slower to resolve than it should have been?

- Cover process gaps as well as technical ones — a missing runbook or unclear ownership counts.
- Be honest about anything that wasted time (wrong dashboard, unclear escalation, a fix that was tried and made things worse) — this is where the next incident's speedup comes from.

## Action items
Concrete follow-ups that address root cause and the gaps above, not just "be more careful."

| Action | Owner | Due date | Status |
|---|---|---|---|

- Write each action as something specific and verifiable, not "improve monitoring" — "add an alert on X threshold" is trackable; "improve monitoring" isn't.
- Every action needs a real owner and due date, or it becomes a to-do nobody does — an action item without an owner is a wish.
- Distinguish immediate mitigations (already done) from preventive follow-ups (still open) if both are listed here.

## Related
Link to the runbook or monitoring-plan this incident should update, if any.

- If this incident revealed a gap in a runbook (a missing symptom, a wrong escalation path), link it here and actually go update that doc — a postmortem that doesn't feed back into the runbook lets the same incident repeat identically.
