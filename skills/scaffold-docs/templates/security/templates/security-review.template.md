---
title: "Security Review: <Feature/Change Name>"
description: Gate a specific feature or change before it ships.
cadence: write-once
reviewer: <name>
date: <date>
status: Approved  # or: Blocked, Approved with follow-ups
---

# Security Review: <Feature/Change Name>

## Scope
What feature/change is being reviewed, and what's out of scope for this review?

- Describe the actual change (a PR, a new integration, an architecture) precisely enough that someone reading this in a year knows exactly what was reviewed.
- Name what's out of scope — a dependency, an adjacent system, a follow-up phase — so nobody later assumes this review covered more than it did.

## Data handled
What data does this feature touch — classification (public/internal/confidential/regulated), and where it's stored/transmitted.

- Classify by the most sensitive data actually touched, not the average — one field of regulated data makes the whole flow regulated.
- Trace the data through its full path (collected, stored, transmitted, logged) — a review that only checks the database and misses the request log is missing where data actually leaks.
- Link to `data-classification-retention-policy.md` for the tier definitions instead of redefining them here.

## Threats considered
Reference the relevant `threat-model.md` if one exists; note anything specific to this change that the broader threat model doesn't cover.

- If a threat model exists for the underlying system, don't re-derive it — cite it and focus only on what this specific change adds or alters.
- If no threat model exists yet, at minimum walk through what new trust boundary or new external input this change introduces.

## Findings
| Finding | Severity | Recommendation | Status |
|---|---|---|---|

- Severity should reflect actual exploitability and impact, not how uncomfortable the finding is to raise — a consistent severity scale (shared with `vulnerability-assessment.md`) keeps findings comparable across reviews.
- "Recommendation" should be specific and actionable (a concrete fix), not "harden this" — the person fixing it shouldn't have to re-derive the finding.
- Status tracks whether each finding was fixed, accepted, or deferred before this review closed — don't let "open" findings quietly vanish once the feature ships.

## Sign-off
Conditions that must be met before this ships, if any.

- List concrete, checkable conditions ("finding #2 fixed and retested"), not "address feedback" — the person shipping should be able to verify each one independently.
- If sign-off is conditional, name who confirms the conditions were actually met before launch — otherwise "approved with follow-ups" quietly becomes just "approved."
