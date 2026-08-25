---
title: "Flow Spec: <Flow Name>"
description: Define one UX flow.
cadence: living
related_prd: /docs/product/prd.md
updated: <date>
---

# Flow Spec: <Flow Name>

## Entry points
Where does a user land in this flow from?

- List every entry point, not just the primary one — a deep link, a nav item, a notification, and an onboarding step often land on the same screen in different states.
- Note any precondition the user must already satisfy to enter here (logged in, has an existing record, feature flag on) — a flow spec that assumes a precondition silently breaks for anyone who doesn't meet it.
- If entry differs by platform or surface (web vs. mobile, first-time vs. returning user), call out the difference instead of describing only one.

## Steps
1. Screen/state →
2. Screen/state →

- Describe each step as a screen/state plus the action that advances it — "user taps Continue" tells a reader more than "Continue screen."
- Branch explicitly wherever the flow forks (a choice, a validation failure, a permission check) — a flow spec that only documents the happy path leaves engineering to guess at every fork.
- Note what data or system state changes at each step, if anything — this is what an engineer needs to know is safe to assume by the next step.

## Edge cases & empty/error states
What happens when a step doesn't go as planned — no data, a failed request, an invalid input, a timeout.

- Cover the empty state for every list/collection screen in the flow, not just the error states — "zero items" is its own design decision, not a placeholder.
- For each error, specify what the user sees and what they can do next (retry, go back, contact support) — an error state with no recovery path is a dead end.
- Note anything that should interrupt the flow entirely (session expiry, permission revoked mid-flow) vs. what should degrade gracefully in place.

*If an edge case changes the number of steps or the entry point, it probably deserves its own flow spec rather than a footnote on this one.*

## Accessibility notes
Keyboard nav, screen reader labels, contrast — anything non-default.

- Call out anything in this flow that isn't handled by the design system's baseline accessibility (a custom control, a non-standard focus order, a modal that traps focus).
- Note where focus should land after each transition (opening a modal, dismissing an error, completing a step) — this is the detail most often missing from a happy-path mock.
- If any step relies on color, motion, or a sound alone to convey meaning, name the redundant cue that also conveys it.

## Design references
Links to Figma/mockups if external.

- Link to the specific frame/state, not just the file — a reviewer shouldn't have to hunt through a Figma page to find the error state you're describing.
- If the linked mockup and this spec ever disagree, say which one wins — otherwise engineering will build from whichever they saw first.
