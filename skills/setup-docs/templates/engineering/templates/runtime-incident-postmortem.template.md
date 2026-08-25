---
title: "Runtime Incident Postmortem: <Incident Title>"
description: Document a production incident caused by application code.
cadence: write-once
author: <name>
date: <date>
severity: <SEV1-4>
status: Draft  # or: Final
---

# Runtime Incident Postmortem: <Incident Title>

*Blameless — this document explains systems and process, not people. For infra/deploy-caused incidents, use `operations/incident-postmortem.md` instead — this one is for incidents caused by application code (a bug, a bad release, an unhandled edge case).*

## Summary
What happened, in two or three sentences.

- Lead with user/business impact, then the mechanism — a reader triaging incidents should get the "so what" before the technical detail.
- Write this section last, after the rest of the doc is filled in; it's easiest to summarize accurately once the root cause and timeline are actually known.

## Timeline
| Time (UTC) | Event |
|---|---|

- Use one timezone consistently (UTC, as the column suggests) — a timeline mixing timezones is a common source of confusion during review.
- Include detection and mitigation milestones, not just the failure itself: when an alert fired, when someone acknowledged it, when the fix was deployed — the gaps between these rows are often the most actionable part of the postmortem.

## Impact
Who/what was affected, for how long, and how was that measured.

- Quantify it: number of users/requests affected, error rate, revenue impact if known — "some users saw errors" doesn't support prioritizing the fix against other work.
- State how the number was measured (a dashboard, a log query) so it can be reproduced or double-checked later.

## Root cause
The specific code path, logic error, or missed edge case that caused this — link to the commit/PR that introduced it if known.

- Go past the proximate trigger to the actual defect — "the service crashed" is a symptom; "an unbounded retry loop on a 500 response exhausted connection pool capacity" is a root cause.
- Link the exact commit/PR/line that introduced the bug if it's known; that's what makes "why it wasn't caught" answerable instead of speculative.

## Why it wasn't caught
What test, review, or monitoring gap let this reach production?

- Name the specific gap (no test covered this input, the reviewer wasn't familiar with this code path, no alert existed for this failure mode) rather than a general "we should test more."

*This section should point at a process or coverage gap, not a person — if the honest answer is "someone made a mistake," ask what would have caught that mistake regardless of who made it.*

## Fix
The fix that resolved this, and whether it's a patch or requires tech-design/ADR-level rework.

- Distinguish the immediate mitigation (what stopped the bleeding) from the actual fix (what prevents recurrence) if they were different things.
- If the real fix needs design work beyond a quick patch, say so and link the tech-design/ADR it should spawn — don't let "we patched it" stand in for "we fixed it."

## Action items
| Action | Owner | Due date | Status |
|---|---|---|---|

- Write each action as something concrete and closeable (a specific test, alert, or code change), not a restatement of the problem — "improve monitoring" isn't an action item; "add an alert on retry-queue depth exceeding N" is.
- Give every action an owner and due date at the time this doc is written; an action item without one tends to never get done.
