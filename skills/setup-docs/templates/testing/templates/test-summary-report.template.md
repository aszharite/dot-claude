---
title: "Test Summary Report: <Release/Cycle Name>"
description: Communicate testing results to stakeholders.
cadence: write-once
author: <name>
date: <date>
scope: <what was tested>
---

# Test Summary Report: <Release/Cycle Name>

## Summary
Overall pass/fail counts and headline result — is this release ready to ship, from a QA perspective?

- Lead with the headline judgment (ready / not ready / ready with caveats) — don't bury the conclusion under raw numbers; stakeholders reading fast need the answer first.
- Give the topline counts (total run, passed, failed, blocked) so the headline judgment is backed by something concrete.

*Write this section last — it should be the conclusion the rest of the report supports, not the first thing you guess at.*

## Results by area
| Area | Passed | Failed | Blocked | Notes |
|---|---|---|---|---|

- Break down by functional area or module, not by test type — stakeholders care whether checkout works, not how many unit tests ran.
- "Blocked" deserves its own honest count separate from "Failed" — a test that couldn't run tells a different story than one that ran and failed, and conflating them hides risk.
- Add a short note per row when the numbers alone don't explain the picture (e.g. "failures are all one root cause," "blocked pending a fixture fix").

## Defects found
| Defect | Severity | Status |
|---|---|---|

- List every defect discovered during this cycle, not just the ones still open — a defect found and fixed within the cycle is still useful history.
- "Status" should match the bug tracker's current state, not a snapshot from when testing started — a stale status here is how a report ships saying "3 open" when it's actually 1.

## Coverage
What was tested, and anything explicitly out of scope for this cycle.

- Name what was actually exercised this cycle, distinct from what the test plan says should eventually be covered — this report is about what happened, not what was intended.
- Call out anything explicitly skipped this cycle (time pressure, environment unavailable, feature flagged off) so it doesn't read as an oversight.

## Recommendation
Ship, ship with known issues, or hold — and why.

- Pick one of the three explicitly — a recommendation that hedges without landing on one defeats the purpose of the report.
- If "ship with known issues," name exactly which issues and reference them — don't leave the reader to infer which defects from "Defects found" are the acceptable ones.
- Say what would change the recommendation (a specific fix landing, a specific test passing) if it's currently a hold.
