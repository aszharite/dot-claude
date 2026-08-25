---
title: "Component Spec: <Component Name>"
description: Deep-dive on a single reusable component.
cadence: living
owner: <name>
updated: <date>
---

# Component Spec: <Component Name>

## Purpose
What this component is for, and when to use it (vs. a similar existing component).

- State the problem this component solves, not just what it looks like — that's what lets someone judge whether it fits a new use case you didn't anticipate.
- If there's a similar existing component, name it explicitly and say what distinguishes them — otherwise expect both to get used interchangeably until they drift apart.

## Variants
| Variant | Use case |
|---|---|

- Each row should answer "when would I reach for this one" — a variant with no clear use case is a sign it should be merged with another or removed.
- If variants are mutually exclusive (only one can apply at a time) vs. combinable, say so — that's a real modeling decision that affects how the component gets built.

## States
Default, hover, focus, disabled, error, loading — whichever apply.

- Only list the states that actually apply to this component — listing every possible state regardless of relevance just buries the ones that matter.
- Note any state combinations that need special handling (e.g. disabled *and* loading, error *and* focus) — these are the combinations that get missed in implementation.

## Anatomy
The parts that make up this component, and which are required vs optional/slotted.

- Name each part (icon, label, helper text, action slot) and mark it required, optional, or slotted-content — this is what tells a consumer what they're allowed to omit or replace.
- Call out any part with a fixed position or behavior that a consumer can't override — otherwise expect someone to try.

## Accessibility
Keyboard interaction, ARIA roles, and screen-reader behavior specific to this component.

- Specify the exact keyboard interactions (which keys do what) if this component has any custom behavior beyond a native `<button>`/`<input>` — custom widgets are where keyboard support is most often skipped.
- State the ARIA role and required ARIA attributes explicitly; if the component wraps a native HTML element with built-in semantics, say so instead of re-deriving ARIA from scratch.
- Note what should happen on focus and on state change (error appears, content loads) — an accessible component still fails if nothing is announced when its state changes.

## Known limitations
Cases this component doesn't handle well, and what to use instead.

- Be specific about the case that breaks (very long text, many items, nesting) rather than a vague "doesn't scale well" — specificity is what lets someone catch the case before they hit it.
- Point to the alternative to use instead, if one exists — a limitation without an alternative just tells someone what not to do, not what to do.
