---
title: "Sitemap: <Product/Section Name>"
description: Document information architecture and navigation structure.
cadence: living
owner: <name>
updated: <date>
---

# Sitemap: <Product/Section Name>

## Structure
Hierarchical listing of pages/sections and how they nest (a diagram or indented list, whichever is easier to keep current).

- Show nesting depth explicitly — a flat list of page names loses the parent/child relationships that are the actual point of a sitemap.
- Include states that are effectively separate destinations even if they share a URL pattern (e.g. an empty vs. populated dashboard) only if they affect navigation; otherwise this becomes a page-by-page spec instead of a map.
- Pick whichever format (diagram or indented list) is easiest for your team to actually update — a sitemap that's a pain to edit will silently go stale.

## Navigation
How users move between sections — primary nav, secondary nav, breadcrumbs.

- Cover every navigation mechanism a user could use to get between sections, not just the primary nav — secondary nav, breadcrumbs, and in-page links all shape how "findable" a section actually is.
- Note any section reachable *only* through a non-obvious path (a link buried in settings, a redirect) — that's exactly the kind of thing a sitemap should surface, not just the obvious top-level structure.

## Access & permissions
Which sections are gated by auth/role, if relevant.

- State the gate explicitly per section (logged-out, logged-in, specific role/plan) rather than a general "some areas require login" — a reader needs to know which sections, not that some exist.
- Note what a user without access sees when they try to reach a gated section (redirect, 404, upsell) — that's a real design decision, not an implementation detail.

## Orphaned or deprecated pages
Anything still live but no longer linked from navigation, so it doesn't get silently forgotten.

- List the page, why it's orphaned (replaced, deprecated, left over from a migration), and whether it's safe to remove or must stay live (e.g. for existing bookmarks/backlinks).
- Revisit this list on a cadence, not just when you happen to stumble on a page — orphaned pages accumulate silently precisely because nothing links to them as a reminder.
