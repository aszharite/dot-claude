---
title: "Data Dictionary: <Table/Dataset Name>"
description: Document fields in one specific database table or dataset.
cadence: living
owner: <name>
updated: <date>
---

# Data Dictionary: <Table/Dataset Name>

## Overview
What this table/dataset represents, and where it lives.

- Name the database/warehouse/schema this table actually lives in — "the users table" is ambiguous across a production DB, a replica, and a warehouse copy that might lag or be reshaped.
- State what one row represents in plain language (e.g. "one row per completed checkout attempt") — that single sentence prevents most misreads of the table downstream.

## Fields
| Column | Type | Nullable | Constraints | Description |
|---|---|---|---|---|

- "Description" is where this table earns its keep — don't just restate the column name; explain what the value means, especially for anything encoded (a status as an integer, a bitmask, a code that maps to an external system).
- "Constraints" should include anything enforced outside the database too (an application-level uniqueness check, a value range only validated in code) — a reader can see database constraints in the schema already; what they can't see is easy to miss here.
- Note units and formats where they're not obvious (timestamps in UTC vs. local, amounts in cents vs. dollars, durations in ms vs. seconds) — this is a common source of downstream bugs.

## Sample values
A few representative rows or example values, especially for enums/codes that aren't self-explanatory.

- For any column with a fixed set of values (an enum, a status code), list all the known values and what each means — a sample of "a few rows" can easily miss a rare-but-valid value.
- Redact or synthesize any real PII before pasting sample rows here; this doc tends to be more widely readable than the table's actual access controls.

## Related tables
Foreign keys or logical relationships to other datasets — link to `data-model.md` for the system-wide view.

- List both formal foreign keys and informal relationships (a column that references another table's ID without a real constraint) — the informal ones are exactly what a new engineer won't discover by reading the schema.
