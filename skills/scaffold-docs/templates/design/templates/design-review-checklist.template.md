---
title: "Design Review Checklist: <Feature/Flow Name>"
description: Verify a design is ready for engineering handoff.
cadence: write-once
reviewer: <name>
date: <date>
status: Approved  # or: Changes requested
---

# Design Review Checklist: <Feature/Flow Name>

## Scope
What's being reviewed before handoff to engineering.

- Name the exact screens/flows covered by this review, and which related surfaces are explicitly out of scope for this pass.
- State which artifact is authoritative for this review (a specific Figma file/version) — reviewing against a stale link produces a checklist that doesn't match what actually ships.

## Checklist
| Item | Status | Notes |
|---|---|---|
| Responsive behavior across breakpoints covered | | |
| Empty, loading, and error states designed | | |
| Accessibility requirements met (contrast, focus order, labels) | | |
| Copy finalized and matches content style guide | | |
| Edge cases from flow-spec addressed | | |

- Add a row for anything specific to this feature beyond the default list above (e.g. a third-party embed, a platform-specific interaction) — the default rows are a floor, not the full checklist for every feature.
- Use "Notes" to record *why* an item is marked as it is, not just pass/fail — "Notes: contrast checked at 4.6:1" is verifiable later; a bare checkmark isn't.
- An item marked incomplete should block approval or get moved to Open issues with an owner — don't let a checklist row go stale as neither done nor tracked.

## Open issues
Anything not yet resolved that shouldn't block handoff but needs tracking.

- Every open issue needs an owner and, ideally, a ticket link — an issue that's "noted" but unowned tends to resurface after engineering has already built around it.
- Be explicit about why each issue doesn't block handoff — that judgment call is worth recording in case it's questioned later.
