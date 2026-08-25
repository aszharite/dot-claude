---
title: "Migration Plan: <Migration Name>"
description: Plan a specific database or infrastructure migration.
cadence: write-once
owner: <name>
updated: <date>
status: Draft  # or: Approved, In Progress, Complete
---

# Migration Plan: <Migration Name>

## Scope
What's being migrated (database, service, infrastructure), from what to what.

- State the starting state and the target state explicitly — "migrating the users table" is ambiguous about whether the schema, the storage engine, or the hosting environment is changing.
- Name what's explicitly out of scope; a migration plan that silently expands scope mid-execution is how maintenance windows overrun.

## Steps & sequencing
Ordered steps, including any required coordination windows or maintenance mode.

- Order steps so each one is independently verifiable before the next begins — a step you can't confirm succeeded is a step you can't safely build on.
- Call out which steps require a coordination window (maintenance mode, a traffic freeze, a specific team on standby) versus which can run unattended.
- Note dependencies between steps and other in-flight work (deploys, other migrations) that could collide with this sequence.

## Data integrity
How correctness is verified during and after migration (checksums, row counts, dual-write/read comparison).

- Specify the actual check (row counts matching, a checksum over key columns, a sample diff between old and new) — "verify the data looks right" isn't a check anyone else can run.
- If using dual-write or dual-read during a transition period, state how long that period lasts and what triggers cutting over fully.

## Rollback plan
Exact steps to revert if the migration needs to be aborted partway through.

- Write this as literal, ordered steps someone else could execute under pressure — not "revert the migration," but the exact commands/scripts and in what order.
- State the point of no return explicitly: the step after which rollback is no longer possible (or becomes much more expensive), so whoever's running this knows when they've crossed it.

## Timeline
Estimated duration per step, and the overall window this needs to happen in.

- Break the estimate down per step, not just as one total — it's what lets someone judge, mid-migration, whether things are running long.
- Include buffer for the verification and rollback-decision steps, not just the mechanical data-moving steps; those are the ones that get rushed when a maintenance window is closing.
