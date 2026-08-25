---
title: "RFC: <Initiative Name>"
description: Propose a larger initiative that will spawn multiple ADRs or tech-designs.
cadence: write-once
author: <name>
updated: <date>
status: Draft  # or: In Review, Accepted, Rejected
---

# RFC: <Initiative Name>

*Precedes a cluster of ADRs/tech-designs — this is the larger initiative, not a single decision or feature.*

## Summary
What's being proposed, in a few sentences.

- Write this as the elevator-pitch version — a reader who stops after this section should still know what's being proposed and roughly why, even if they read nothing else.

## Motivation
What problem does this initiative solve, and why now? What happens if we don't do this?

- Ground this in something observable (a recurring cost, a metric trend, a capability competitors or users are asking for) rather than a general sense that something should be better.
- Answer "why now" specifically — an RFC that's equally true at any point in time is a sign the timing case hasn't actually been made.

## Proposed approach
The overall direction — enough detail to evaluate the shape of the solution, not full implementation detail (that belongs in the tech-designs/ADRs this RFC leads to).

- Describe the shape of the solution (the major systems touched, the overall sequencing) at a level someone could disagree with the *direction* without needing to review code — implementation-level detail belongs downstream in tech-designs.
- If there are a few genuinely different shapes this could take, it's fine to present the leading option plus why the others weren't chosen, rather than only ever showing one path.

## Alternatives considered
Other directions considered and why they were set aside.

- Include the "do nothing" or "keep doing what we do today" option — it's the implicit baseline this RFC is arguing against, and naming it makes that argument explicit.
- Give a real reason each alternative was set aside (cost, timeline, doesn't solve the whole problem), not just that it was considered.

## Scope & phasing
What's in v1 vs later phases, and roughly how this breaks down into the individual decisions/designs that will follow.

- Be explicit about what ships in the first phase versus what's deferred — an RFC that reads as all-or-nothing tends to stall because the full scope feels too large to approve at once.
- Sketch how this decomposes into the ADRs/tech-designs it will spawn; that's what turns an accepted RFC into actual tracked work instead of a document that gets accepted and then stalls.

## Open questions
What's still unresolved before this can move to implementation.

- Separate questions that block acceptance of the RFC itself from ones that can be resolved during one of the downstream tech-designs.
- Assign an owner where you can; an open question with no owner tends to stay open past the point where it should have blocked something.

## Related decisions
Link to the ADRs and tech-designs this RFC spawns, once they exist.

- Keep this list updated as the downstream ADRs/tech-designs actually get written — an RFC with a stale or empty list here becomes hard to trace once the initiative is underway.
