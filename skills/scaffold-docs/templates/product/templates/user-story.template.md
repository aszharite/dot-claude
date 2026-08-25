---
title: "User Story: <Story Title>"
description: Describe one deliverable slice from the user's perspective.
cadence: living
related_prd: <link>
updated: <date>
status: Backlog  # or: In Progress, Done
---

# User Story: <Story Title>

## Story
As a <type of user>, I want <goal>, so that <benefit>.

- Name the actual user type, not "user" — which persona or role is this for, and does the story change if it's a different one?
- State the goal as what the user is trying to accomplish, not the UI action ("find my past orders," not "click the orders tab").
- The benefit is the "so that" — if you can't fill it in honestly, the story may not be worth doing yet, or you haven't found the real reason.

*Keep the story to one deliverable slice — if the goal needs three different flows to be true, split it into separate stories.*

## Acceptance criteria
Numbered, testable conditions that define "done."

- Write each criterion as an observable behavior ("clicking X shows Y"), not an internal implementation detail.
- Cover the unhappy paths too — invalid input, empty state, permission denial — not just the golden path.
- If a criterion can't be checked by looking at the running product, it's probably not an acceptance criterion — it belongs in Notes instead.

1.
2.

## Out of scope
What this story explicitly does NOT cover.

- List adjacent behavior that looks related but is being deliberately deferred or handled by a different story — link to that story if one exists.
- This is where you write down the "wait, does this also..." questions before someone asks them in review.

## Notes
Dependencies, edge cases, design/API links.

- Note anything this story is blocked on or blocks — another story, a design file, an API that doesn't exist yet.
- Edge cases you considered but decided not to handle now still belong here, distinct from Out of scope (a deliberate exclusion, vs. known-but-deferred).
