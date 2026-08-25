---
title: "Test Plan: <Feature Name>"
description: Plan testing for one feature or release.
cadence: living
related_prd: /docs/product/prd.md
updated: <date>
---

# Test Plan: <Feature Name>

## Scope
What's covered by this plan, and what's explicitly out of scope.

- Name the specific feature, flow, or release this plan covers, and link the PRD requirement(s) it maps to (see `related_prd` above) so scope isn't invented from scratch.
- Call out what's explicitly NOT covered here (a related feature already has its own test plan, a platform is deferred) — an unstated exclusion gets discovered mid-cycle when someone assumes it's covered.
- Note any dependencies this plan assumes are already tested elsewhere (a shared library, an upstream service) so this plan doesn't silently re-test someone else's contract.

*If scope keeps growing as you write this, the PRD's requirements probably weren't specific enough — go fix those first.*

## Test strategy
Unit / integration / e2e / manual — what's covered at each level and why.

- For each level, say what kind of defect it's meant to catch, not just "we do integration tests" — the reasoning is what tells a reader whether a gap is a real risk.
- Be explicit about what's manual-only and why (hard to automate, low ROI, one-off) — manual coverage that's never written down tends to quietly stop happening.
- Flag anything intentionally covered elsewhere (see the team's `test-strategy.md` for defaults) so this plan doesn't duplicate or contradict it.

## Acceptance criteria
Testable, tied back to PRD requirements. Each PRD requirement should map to at least one row here.

| Requirement | Test case | Pass criteria |
|---|---|---|

- "Requirement" should reference the PRD requirement directly — copy it, don't paraphrase, so the link survives PRD edits.
- "Test case" should be specific enough that two different people would run the same steps — "test login" isn't a test case; "invalid password shows inline error, does not redirect" is.
- "Pass criteria" should be a single unambiguous outcome — if you can't tell from the criteria alone whether it passed, rewrite it.

## Coverage gaps / known risks

- List requirements or scenarios this plan deliberately doesn't cover, and why (time, tooling, low risk) — an unlisted gap looks like an oversight; a listed one looks like a decision.
- Note anything you're relying on manual/exploratory testing to catch instead of automated coverage.
- If a gap is worth someone above you knowing about before ship, say so explicitly rather than burying it in a bullet.
