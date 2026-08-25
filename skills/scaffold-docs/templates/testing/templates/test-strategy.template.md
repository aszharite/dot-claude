---
title: "Test Strategy: <Project/Team Name>"
description: Define the cross-project testing approach.
cadence: living
owner: <name>
updated: <date>
---

# Test Strategy: <Project/Team Name>

## Testing pyramid
What's the intended split between unit, integration, and end-to-end tests, and why?

- State the target ratio (even roughly, e.g. "mostly unit, a thin layer of integration, very few e2e") and the reasoning behind it — speed, flakiness, maintenance cost — not just the shape.
- Call out where the actual test suite diverges from this pyramid today, if it does; a strategy that doesn't acknowledge current reality won't be trusted.
- Note what makes something a unit vs. integration test *here*, if the team's definitions aren't the textbook ones — ambiguity here is what causes the pyramid to drift unnoticed.

## Tooling
Frameworks, runners, CI integration, coverage tooling.

- List the actual tools by name (and version where a migration is in progress or a version pin matters).
- Say how tests run in CI — which pipeline stage, what blocks a merge vs. what's advisory — not just that they run.
- Note any tooling gaps (no coverage tool configured, no flaky-test tracking) rather than omitting the section entirely.

## Coverage targets
Minimum coverage expectations, if any, and what's explicitly exempt (e.g. generated code, third-party integrations).

- If there's a numeric target, say what it's measured on (line, branch, changed-lines-only) — different tools default to different things, and comparisons break silently otherwise.
- Name what's exempt and why, explicitly — generated code, vendored dependencies, or throwaway scripts can inflate or deflate the number if left unstated.
- If there's no enforced target, say so — "no target" is a real answer, and better than a stale number nobody actually enforces.

## Environments
What environments exist (local, CI, staging) and what runs where.

- List each environment and what class of test runs there (unit locally + CI, e2e in staging, etc.) — a suite that "works everywhere" usually doesn't.
- Note any environment-specific quirks that cause false results (seeded data differences, feature flags defaulting differently), especially if they aren't already covered by a `test-data-spec.md`.

## Ownership
Who is responsible for writing/maintaining tests for which parts of the system — engineering, QA, or shared.

- Name the actual owner per area (a team, not "everyone") — shared ownership with no name attached is how flaky tests sit ignored for months.
- Say what happens when a test starts failing in CI — who's paged, who has authority to skip/quarantine it, and how that gets tracked back to a fix.
