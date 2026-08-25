---
title: "Data Contract: <Producer> → <Consumer(s)>"
description: Define a producer/consumer data agreement between teams.
cadence: living
owner: <name>
updated: <date>
---

# Data Contract: <Producer> → <Consumer(s)>

## Producer & consumers
Who owns/produces this data, and who consumes it downstream.

- Name the producer as a specific team/service, not "the backend" — someone needs to know who to page when this contract is violated.
- List every known consumer, including ones that consume indirectly (via a downstream pipeline) — a producer that only tracks direct consumers will break someone it didn't know existed.

## Schema
Fields, types, and whether each is guaranteed-present or optional — link to the actual schema definition rather than duplicating it.

- Link to the canonical schema (a `.proto`, an Avro/JSON schema, a table definition) rather than retyping every field here; a duplicated schema drifts the moment either copy changes.
- Call out which fields are guaranteed present on every record vs. optional/nullable — consumers need to know this to write defensive parsing code correctly.

## Guarantees
What the producer commits to (schema stability, delivery ordering, freshness/latency, backward compatibility on change).

- Be specific and falsifiable: "delivered within 5 minutes of the event" is a guarantee a consumer can build alerting against; "delivered promptly" isn't.
- State what's *not* guaranteed as clearly as what is (e.g. "no ordering guarantee across partitions") — consumers who assume an unstated guarantee are the ones who get burned when it doesn't hold.

## Change process
How the producer notifies consumers of a breaking or non-breaking schema change, and the required notice period.

- Define what counts as breaking for this contract (removing a field, narrowing a type, changing semantics of an existing value) vs. non-breaking (adding an optional field) — this determines which changes need advance notice at all.
- State the actual notice period and channel (e.g. "30 days notice via the #data-contracts Slack channel and an email to registered consumers") — a change process with no enforceable notice period is really just "changes happen and you find out."

## Consumption expectations
What consumers must handle gracefully (e.g. unknown new fields, occasional duplicates, out-of-order delivery).

- List the specific failure modes a consumer must tolerate without erroring (an unrecognized new field, an occasional duplicate record, a late or out-of-order delivery) — these are usually the actual cause of consumer-side incidents when a producer's implementation details leak through.
- If consumers are expected to be idempotent or tolerant of replay, say so explicitly — that's an architectural requirement on the consumer side, not a minor detail.
