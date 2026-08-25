---
title: "Design System Reference: <System/Product Name>"
description: Document the design system as a whole — colors, typography, components, patterns.
cadence: living
owner: <name>
updated: <date>
---

# Design System Reference: <System/Product Name>

## Foundations
Color, typography, spacing, elevation — link to the source of truth (Figma library, tokens file) rather than duplicating values here.

- Link to the actual tokens (a Figma library, a `tokens.json`, a CSS variables file) instead of pasting hex codes and pixel values that will drift out of sync the next time someone updates the source.
- If you must state a value here, state *why* it's what it is (a brand constraint, an accessibility minimum) rather than just the number — the number is already in the source of truth.
- Note anything foundational that's mid-migration (e.g. old spacing scale still used in legacy screens) so readers know which value is current.

## Components
| Component | Variant(s) | States | Usage notes |
|---|---|---|---|

- List components at the level a consumer picks from, not every internal sub-part — "Button" and its variants belong here; the divs that make it up don't.
- "Usage notes" is where you capture the thing people get wrong: when to reach for this component vs. a similar one, or a common misuse worth flagging.
- Link each row to its full `component-spec.md` if one exists, instead of trying to fit everything about the component into this table.

## Patterns
Recurring compositions (e.g. empty states, form validation, confirmation flows) that combine components consistently across the product.

- Document the pattern, not just name it — what components it's built from, and the rule for when to use it over a one-off composition.
- Patterns are where inconsistency creeps in fastest across a large product; if you find two screens solving the same problem differently, that's a signal a pattern needs to be named and enforced here.

## Deviations
Places where a flow intentionally breaks from the system, and why — prevents "was this a bug or a decision?" churn later.

- Record the deviation *and* the reason (a one-off partner requirement, a legacy constraint, a deliberate exception) — without the reason, the next person who finds it will "fix" it back to the standard.
- Note whether the deviation is permanent or has a planned expiration (e.g. reverts once a migration completes) — an undated deviation tends to outlive its justification.

*An undocumented deviation is indistinguishable from a bug the next time someone audits the product — that's what this section exists to prevent.*
