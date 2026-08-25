---
title: "On-Call Handbook: <Team/Service Name>"
description: Onboard a new on-call engineer to the team and rotation.
cadence: living
owner: <name>
updated: <date>
---

# On-Call Handbook: <Team/Service Name>

## Rotation
How the rotation is structured, how to swap shifts, and where the schedule lives.

- Link directly to the live schedule tool, not a static description that will drift out of date.
- State shift length and handoff time explicitly — ambiguity about when a shift starts/ends is how pages get missed at the boundary.
- Explain the actual swap process (who to ask, how it's approved) since this is usually needed on short notice.

## Getting access
Tooling, dashboards, and systems an on-call engineer needs access to before their first shift — with links to request access.

- List every system needed to actually resolve an incident (paging tool, prod console, logs, deploy pipeline), not just the ones needed to be notified.
- Include expected turnaround time for each access request — discovering a request takes 3 business days during someone's first on-call week is a bad time to find out.
- Flag anything that needs to be requested *before* the rotation starts, since some access grants aren't instant.

## Escalation paths
Who/what to escalate to when you can't resolve something alone, and how (paging tool, Slack channel, phone).

- Give the actual mechanism (a specific paging tool action, not "call someone") — vague escalation instructions cost time exactly when time matters most.
- Cover escalation both within the team (secondary on-call) and outside it (adjacent teams, vendor support), since not every incident stays within one team's boundary.

## Expectations
Response time SLAs, what counts as an emergency vs something that can wait until business hours.

- Give a concrete acknowledgment time (e.g. "acknowledge within 5 minutes"), not "respond promptly" — an unmeasurable expectation can't be met or missed.
- Give examples of what does and doesn't warrant waking someone up — this is the single most common new-on-call anxiety, and a vague answer doesn't resolve it.

## First 15 minutes
A short checklist for what to do the moment a page fires, before diagnosing the actual problem.

- Order these as immediate, low-judgment actions (acknowledge the page, check the dashboard, post in the incident channel) — the goal is to stop the bleeding and orient, not to have fixed it.
- Include when/how to declare a formal incident, if the team has a separate incident-declaration process from just "being on-call."
