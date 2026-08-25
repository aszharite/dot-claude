---
title: "Release Sign-off: <Release/Version Name>"
description: Formally approve a release from QA.
cadence: write-once
qa_lead: <name>
date: <date>
decision: Go  # or: No-Go, Go with known issues
---

# Release Sign-off: <Release/Version Name>

## Scope
What's included in this release.

- List the features, fixes, and changes actually shipping — pull this from the release notes/changelog rather than re-deriving it, so the two documents can't drift apart.
- Note anything that was originally planned for this release but got cut — a scope that silently shrank without a record makes the sign-off look like it covers more than it does.

## Test results
Link to the `test-summary-report.md` this sign-off is based on.

- Link the specific report, not a general testing area — this sign-off should be traceable to one concrete set of results, not "testing happened."
- If sign-off is happening without a completed test-summary-report, say that explicitly and why (time pressure, low-risk change) rather than implying full coverage.

## Open defects
| Defect | Severity | Deferred to |
|---|---|---|

- Include every known defect still open at release time, not only the ones judged blocking — "Deferred to" makes the decision visible instead of hiding it by omission.
- "Deferred to" should name an actual target (a version, a date, a ticket) — "later" isn't a deferral, it's how known issues get forgotten.

## Risk assessment
Residual risk of shipping with any open items above, and why it's acceptable (or not).

- Assess risk per open defect from the table above, not just in the aggregate — one high-severity open defect can outweigh five low-severity ones.
- Say explicitly why the residual risk is acceptable (low blast radius, easy rollback, workaround exists) — "we think it's fine" without reasoning doesn't hold up when something does go wrong.

## Sign-off
Formal approval record — who approved, and any conditions attached.

- Record actual names and the actual decision (Go / No-Go / Go with known issues), matching the `decision` field in the frontmatter.
- Note any conditions attached to a Go (e.g. "contingent on rollback plan being tested," "monitor error rate for first hour") — a conditional approval without the condition written down becomes an unconditional one in practice.
