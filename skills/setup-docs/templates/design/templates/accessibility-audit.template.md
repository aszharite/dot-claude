---
title: "Accessibility Audit: <Surface/Flow Name>"
description: Audit a surface or flow for accessibility issues.
cadence: write-once
auditor: <name>
date: <date>
standard: WCAG 2.1 AA
---

# Accessibility Audit: <Surface/Flow Name>

## Scope
What surface/flow was audited, and what was excluded?

- Name the exact screens/states covered — "the checkout flow" is ambiguous if the flow has five error states and only three were tested.
- State what was explicitly excluded and why (out of scope for this release, covered by a separate audit, not yet built) — an unstated exclusion reads as "passed" to anyone skimming the findings.
- Note the assistive tech, browser, and OS combinations tested; a pass on one combination isn't a pass on all of them.

## Findings
| Criterion | Status | Issue | Severity | Recommendation |
|---|---|---|---|---|

- "Criterion" should reference the specific WCAG success criterion (e.g. 1.4.3 Contrast Minimum), not a vague description — that's what lets someone map a finding back to the standard.
- "Severity" needs a consistent scale (e.g. blocker/major/minor) applied the same way across findings, or triage will default to whoever complains loudest.
- "Recommendation" should be actionable enough to hand directly to an engineer — "fix the contrast" is weaker than "darken the label text to at least #595959 on white."

## Keyboard navigation
Can every interactive element be reached and operated without a mouse?

- Walk the tab order start to finish and note anything skipped, trapped, or visited out of visual order — a keyboard user can't infer visual order.
- Check that every reachable control also has a visible focus indicator; a control that's reachable but invisible when focused is still a failure for sighted keyboard users.
- Test the operations, not just the reach — a menu item can be focusable and still lack an Enter/Space handler.

## Screen reader
Tested with: <VoiceOver/NVDA/JAWS/etc.> — note anything mislabeled, unannounced, or out of order.

- Name the specific screen reader *and* browser pairing tested (behavior differs across combinations); a finding tied to only one pairing should say so.
- Check that dynamic changes (form errors, loading states, toasts) are actually announced, not just present in the DOM — a visually obvious error can be silent to a screen reader.
- Note anything read in a confusing order relative to its visual position, since that's a common gap between "technically has a label" and "actually usable."

## Color & contrast
Any text/UI elements failing contrast ratios?

- Check contrast for text, but also for non-text UI (icons, input borders, focus indicators) — these have their own, often-missed WCAG minimums.
- Test contrast in every state a component appears in (disabled, hover, on a colored background), not just its default appearance.
- Record the actual measured ratio next to the required minimum, not just pass/fail — that makes it clear how close (or far) a near-miss actually is.

## Remediation plan
Link to the tickets/PRs that will fix each finding above, and target dates.

- Every finding above should map to a ticket here, even if the ticket is "won't fix, tracked as a known limitation" — an audit finding with no linked follow-up tends to get re-discovered from scratch next audit.
- Prioritize by severity and how many users are blocked, not by which fix is easiest — an easy fix for a rare edge case shouldn't jump ahead of a blocker.
