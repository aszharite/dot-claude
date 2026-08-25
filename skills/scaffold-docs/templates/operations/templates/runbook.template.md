---
title: "Runbook: <Service/System Name>"
description: Give on-call engineers a per-service quick-reference for deploy/rollback and common incidents.
cadence: living
updated: <date>
audience: on-call / deploy agent
---

# Runbook: <Service/System Name>

## Deployment
Steps, prerequisites, rollback procedure — everything someone needs to safely ship or revert this specific service.

- Link to the full `deployment-guide.md` for the "why" and detailed prerequisites; keep this section limited to the commands/steps specific to this service.
- Call out anything non-standard about this service's deploy (manual approval gates, order-dependent services, migration timing) that would surprise someone used to the default pipeline.
- State the rollback command or procedure explicitly here too — don't make an on-call engineer hunt through a separate doc mid-incident.

*If deploying this service requires a step nobody remembers the reason for, that's worth investigating, not just documenting.*

## Monitoring & alerting
What's monitored, alert thresholds, where dashboards live — the fastest path from "something's wrong" to "here's the signal."

- Link the actual dashboard URLs, not just their names — a runbook that requires searching for a dashboard during an incident has failed its purpose.
- Note which alerts page immediately vs. which are informational, so on-call knows what warrants dropping everything.
- If this service shares a dashboard with others, say what to look for that's specific to this service.

## Common incidents
Known failure modes for this service and how to respond, so on-call doesn't have to reason from first principles at 3am.

| Symptom | Likely cause | Response |
|---|---|---|

- Fill this in incident by incident — after a postmortem, add the symptom you'd have wanted to search for at 2am.
- "Symptom" should be what's *observed* (an alert name, a dashboard shape, a user report), not the underlying cause — that's the point of the next column.
- "Response" should be the immediate mitigation, not the permanent fix — link to a fuller writeup if the fix is involved.
- If a row's response is "escalate," say so — not every incident should be self-serve.

## Escalation
Who/what to page if the above doesn't resolve it.

- Name an actual person/team/rotation, not "the backend team" — vague escalation paths are why incidents stall waiting for someone to notice.
- Include how to escalate (paging tool, phone, Slack) as well as who, and what to say when you do.
- Note if escalation differs by time of day or severity (e.g. a secondary on-call only pages after N minutes).
