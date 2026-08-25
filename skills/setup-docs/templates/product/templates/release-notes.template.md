---
title: "Release Notes: <Version/Date>"
description: Communicate what shipped, to users.
cadence: write-once
date: <date>
audience: <customers/internal>
---

# Release Notes: <Version/Date>

## Highlights
The one or two changes users will actually notice or care about.

- Pick from the user's perspective, not the release's — the biggest engineering effort isn't necessarily what a user notices first.
- If nothing in this release is worth highlighting, say so plainly rather than inflating a minor change to fill the section.

## New features

- Describe what a user can now do, not what was built — lead with the capability, not the component or project name.
- Link to docs or a short how-to if the feature needs any explanation to use.

## Improvements

- Changes to existing behavior belong here, not New features — be clear about what changed from before, especially if it alters a workflow people already rely on.
- Include improvements a user would notice even if they're "just" performance or polish, not only new user-facing capabilities.

## Bug fixes

- Describe the symptom that's fixed, not the internal cause — "fixed an issue where X would fail when Y," not "fixed a null pointer in the Z module."
- Only list fixes a user could plausibly have noticed; internal-only fixes belong in an engineering changelog, not here.

## Known issues
Anything shipped with a known limitation, and the workaround if there is one.

- Every known issue needs a workaround or an honest "no workaround yet" — silence reads as if the issue was missed, not chosen.
- *List only issues that survived to release deliberately — bugs caught and fixed before ship don't belong here.*
