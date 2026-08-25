---
title: "Tech Debt Log: <System/Team Name>"
description: Record a deliberate shortcut taken during implementation.
cadence: append-only
owner: <name>
updated: <date>
---

# Tech Debt Log: <System/Team Name>

## Entries
Each row is one deliberate tradeoff, not a bug ticket — capture what was skipped, why, and what it will cost if it's never revisited. Add a row at the time the shortcut is taken, while the reasoning is still fresh, rather than trying to reconstruct it later.

| Date added | Description | Reason it was taken | Expected cost if unpaid | Owner | Status |
|---|---|---|---|---|---|

## How to use this log
Add an entry whenever a deliberate shortcut is taken (not for accidental bugs) — the point is making the tradeoff visible, not just the debt.

- A deliberate shortcut has a reason behind it at the time ("shipping without pagination to hit the launch date"); a bug is an unintended defect — if there was no conscious tradeoff, it belongs in the issue tracker instead.
- Revisit the log periodically (a quarterly review is common) and update Status — an entry that's sat as "Open" for a year with no reassessment has effectively become permanent, silently.
- "Expected cost if unpaid" should be concrete enough to justify prioritizing the fix later (e.g. "query time degrades linearly with row count, unusable past ~500k rows") — a vague cost gets deprioritized forever.
