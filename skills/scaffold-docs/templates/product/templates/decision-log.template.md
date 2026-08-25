---
title: "Decision Log: <Team/Product Name>"
description: Track a non-architectural product decision.
cadence: append-only
owner: <name>
updated: <date>
---

# Decision Log: <Team/Product Name>

*For architectural decisions, use an ADR instead (`engineering/adr/`); this is for product/process decisions.*

## Decisions
Add a row whenever a product or process decision is made that someone might later ask "why did we do it this way?" about — not every small call, but anything non-obvious or costly to reverse.

- "Options considered" should include what was rejected, not just what was chosen — the rejected options are what stop the same debate from restarting later.
- "Rationale" should hold up on its own months later, without needing to remember the meeting where it was decided.
- This log is append-only: if a decision changes, add a new row referencing the old one rather than editing history.

| Date | Decision | Options considered | Rationale | Owner |
|---|---|---|---|---|
