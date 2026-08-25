---
title: "Traceability Matrix: <Project/Release Name>"
description: Verify every requirement has test coverage, project-wide.
cadence: living
owner: <name>
updated: <date>
---

# Traceability Matrix: <Project/Release Name>

## Matrix
| Requirement (PRD ref) | Test case(s) | Status |
|---|---|---|

- "Requirement (PRD ref)" should point at the exact requirement, not just the PRD title — pull the requirement number so this stays traceable as the PRD grows.
- "Test case(s)" should list every test that exercises this requirement, across levels (unit, integration, e2e, manual) — a requirement can and often should map to more than one.
- "Status" should reflect current reality (not covered / in progress / passing / failing), kept current as tests are written, not just filled in once at the start.

*This table's value comes entirely from completeness — a matrix missing half the requirements is worse than no matrix, because it looks authoritative.*

## Coverage gaps
Requirements with no linked test case — the whole point of this doc is making these impossible to miss.

- List every requirement from the matrix above with an empty or weak "Test case(s)" column — don't let a gap hide inside a technically-non-empty row.
- For each gap, say whether it's temporary (test not written yet) or a deliberate decision (won't be automated) — those need different follow-up.

## Notes
Any requirement intentionally left untested, and why (e.g. covered by manual exploratory testing only).

- Distinguish "intentionally untested" from "gap" above — this section is for decisions, the gaps section is for things still needing action.
- Record who made the call to leave it untested, in case it needs revisiting later.
