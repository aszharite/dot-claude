---
title: "Content Style Guide: <Product Name>"
description: Define UI copy, voice, and tone rules.
cadence: living
owner: <name>
updated: <date>
---

# Content Style Guide: <Product Name>

## Voice & tone
How the product "sounds" — and how tone shifts by context (e.g. onboarding vs error states).

- Describe voice with a few adjectives plus a contrast ("confident but not glib") rather than a single word — a single word leaves too much room for interpretation.
- Cover how tone shifts by context; a product typically sounds more reassuring in an error state and more upbeat in onboarding than it does in an inbox notification.
- If you can, name examples of tone that would be *wrong* for this product — knowing what to avoid is often clearer guidance than what to aim for.

## Terminology
| Term | Use | Don't use |
|---|---|---|

- Include terms where the product has picked one word over a plausible synonym (e.g. "workspace" not "team," "delete" not "remove") — this table exists precisely for the cases where reasonable people would disagree.
- Add a term the moment two people on the team use different words for the same concept in shipped copy — that's the actual trigger for this table growing, not a periodic audit.

## Formatting conventions
Capitalization, punctuation, number formatting, date/time formatting.

- Cover capitalization style for UI elements (buttons, headers, labels) specifically — sentence case vs. title case is one of the most inconsistent details across a product if it's not written down.
- Specify number and date/time formatting rules, including how they change (or don't) across locales — this is easy to skip until localization surfaces the inconsistency.
- Note punctuation conventions for common UI text (does a button label ever end in a period? do tooltips?) since these are usually decided ad hoc otherwise.

## Writing patterns
Standard phrasing for recurring UI moments (empty states, confirmations, error messages) so they stay consistent across the product.

- Give a reusable structure for each recurring moment (e.g. error messages: what happened + what to do next), not just a single canned example — a structure transfers to cases you haven't written yet.
- Cover the moments that repeat most across the product first (empty states, destructive-action confirmations, validation errors) since inconsistency there is the most visible to users.
