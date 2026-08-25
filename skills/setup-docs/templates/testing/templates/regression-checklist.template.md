---
title: "Regression Checklist: <Product/Release Name>"
description: Manually verify nothing broke before a release.
cadence: living
owner: <name>
updated: <date>
---

# Regression Checklist: <Product/Release Name>

## Core flows to verify
| Flow | Steps | Expected result | Status |
|---|---|---|---|

- Pick flows by business impact and blast radius, not by what's easiest to test — the flow that makes money or that everyone touches belongs here even if it's tedious to check.
- Write "Steps" tightly enough that someone running this cold, without feature knowledge, can execute it the same way every time — this checklist is only reliable if it's repeatable across whoever runs it.
- "Expected result" should be a concrete, checkable outcome ("order confirmation page shows order number"), not "works correctly."
- Update this list when flows change — a checklist testing a flow that no longer exists gives false confidence while missing what actually shipped.

## Environment
Where this checklist should be run (staging, pre-prod) and any setup required.

- Name the exact environment, not "a staging-like environment" — differences from prod (data, config, scale) change what a pass here actually proves.
- List any setup needed before starting (test accounts, seeded data, feature flags) — someone running this under release pressure won't have time to reverse-engineer prerequisites.

## Sign-off
Who ran this pass, when, and whether the release is clear to proceed.

- Record the actual run, not a template intent — who ran it, on what date/build, against how many of the flows above.
- If the pass wasn't clean, say explicitly what failed and whether that blocks the release or is accepted as a known issue — unresolved failures with no note here look like a pass when they weren't.
