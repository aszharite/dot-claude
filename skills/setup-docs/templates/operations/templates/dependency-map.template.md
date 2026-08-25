---
title: "Dependency Map: <Service Name>"
description: Document what a service depends on, for blast-radius awareness.
cadence: living
owner: <name>
updated: <date>
---

# Dependency Map: <Service Name>

## Upstream dependencies
Services/vendors this system calls, and what happens if each is unavailable (hard dependency vs degraded-but-functional).

- For every dependency, answer "what actually happens to this service" if it disappears right now — timeout and fail? serve stale/cached data? fail closed?
- Distinguish dependencies this service can't function without from ones it degrades gracefully without — that distinction is the whole point of this section.
- Include third-party/vendor dependencies, not just internal services — an external API outage is invisible until it's mapped here.

## Downstream dependents
Services/teams that depend on this system, so you know who's affected if it goes down.

- List actual consumers, including ones outside your team, so an incident here can notify the right people without hunting them down mid-outage.
- Note which downstream consumers are hard-dependent vs. can tolerate this service being briefly unavailable.

## Blast radius
If this service fails entirely, what's the realistic scope of impact?

- Trace the failure outward through the downstream dependents above, not just the immediate consumer — cascading impact is usually wider than the first hop.
- State this in terms a non-engineer stakeholder would understand (which user-facing features break), not just which services go red.

## Single points of failure
Any dependency with no fallback — flagged explicitly so it's a known risk, not a surprise during an incident.

- A single point of failure isn't automatically a problem to fix immediately, but it must be a *known, accepted* risk, not an undocumented one.
- Revisit this list whenever a new dependency is added — SPOFs tend to get introduced quietly by a well-intentioned integration.
