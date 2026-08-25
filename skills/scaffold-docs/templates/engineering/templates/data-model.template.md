---
title: "Data Model: <Domain/Service Name>"
description: Define entities and relationships across a system.
cadence: living
owner: <name>
updated: <date>
---

# Data Model: <Domain/Service Name>

## Entities
The core nouns in this domain — the things that get created, queried, and referenced elsewhere in the system.

| Entity | Description | Owning service |
|---|---|---|

- List every entity a consumer of this system would need to know about, not just database tables — an entity can span multiple tables or be assembled from an API response.
- "Owning service" matters even in a monolith: it's whoever has the authority to change this entity's shape. If two services both think they own the same entity, that's worth resolving before it becomes a migration conflict.

## Schema
Key fields per entity, types, and constraints — link to the actual schema/migration source of truth rather than duplicating it wholesale.

- Duplicate the schema here only if there isn't already a canonical source (a migration file, an ORM model, a `.proto`); if one exists, link to it and call out what's non-obvious instead (why a field is nullable, why an enum has the values it does).
- Constraints worth naming explicitly: uniqueness, foreign keys, check constraints, and anything enforced at the application layer instead of the database — that last category is exactly what a new engineer won't discover just by reading the schema.

## Relationships
How entities relate (1:1, 1:many, many:many) and what enforces referential integrity.

- State the cardinality explicitly, not just "related to" — "one order has many line items" tells a reader something "orders relate to line items" doesn't.
- Say what enforces it: a foreign key constraint, an application-level check, or nothing. If it's nothing, flag that explicitly — it's a place data can silently go inconsistent.

## Lifecycle
How does a record get created, updated, archived, or deleted? Note anything soft-delete, versioned, or event-sourced.

- Walk through the entity's states from creation to eventual removal, if it's ever removed at all.
- Soft-delete, versioning, and event-sourcing all change what "the current data" even means for a reader — call out which pattern applies per entity if it's not uniform across the whole model.

## Invariants
Rules that must always hold true (e.g. "an order always has at least one line item") — the things a migration or bugfix must never violate.

- Write these as statements that are either true or false at any point in time, not as process descriptions.
- This is the section worth re-reading before writing a migration or a bulk data-fix script — an invariant violated by a one-off script is still a violated invariant.
