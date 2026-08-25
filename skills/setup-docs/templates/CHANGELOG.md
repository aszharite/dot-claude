---
title: "Documentation Changelog"
description: Append-only log of changes to files under /docs, most recent date first.
cadence: append-only
---

# Documentation Changelog

Tracks changes to files anywhere under `/docs` — not the product's own changelog (see `product/release-notes.template.md` for that, which is user-facing). Whenever an agent or a human adds, edits, removes, or renames a file under `/docs` — including this file's own category and this file itself — record it here in the same change set as the doc change.

- **Structure**: each date is an `##` heading (`YYYY-MM-DD`), most recent date first, directly below this list. Each changed file under that date is a `###` heading, using its path relative to the repo root. Under a file heading, each change is a `**By ...**` attribution line followed by a one-paragraph summary.
- **New date**: if today isn't already the first `##` heading in the file, add a new one at the very top of the log (directly below this list), then add the file's `###` heading under it.
- **Same day, same file**: if today's `##` date and this file's `###` heading both already exist, append another `**By ...**` + summary pair under that existing heading instead of duplicating it.
- **Same day, different file**: add a new `###` heading for the file under today's existing `##` date section.
- **Different day, same file**: the file gets a fresh `###` heading under the new day's `##` section — the same path appearing under multiple dates is expected, not a duplicate.
- **Attribution**: `**By <name>**` for a human editing directly. An agent entry is never bare — it always carries context for what drove it: `**By <agent>, obo <name>**` when a specific person asked for the change (the common case), or `**By <agent>, via <trigger>**` when something other than a direct request drove it — a scheduled/CI job, a lint or freshness check, another automation — naming that trigger (e.g. `By Claude, via nightly freshness check`, `By Codex CLI, via PR #482 review`). Never write a plain `**By Claude**` or `**By Agent**` with no `obo`/`via`.
- **Summary**: one paragraph — enough for someone skimming months later to know whether to open the file. This can carry more detail than a one-line entry since a heading-scoped change may be substantial.
- **Append-only**: never edit or delete a past entry. A later revert gets its own new `**By ...**` + summary entry, not an edit to the original.

<!-- Example of the shape once entries exist (same day, one file touched by two people, a second file touched once):

## 2026-08-25

### docs/engineering/adr/0001-use-postgres.md

**By Claude, obo Jane Doe**

Added an ADR recording the decision to use Postgres over DynamoDB for the billing service, including the rejected alternatives and the rationale.

**By Jane Doe**

Fixed a typo in the consequences section during review.

### docs/testing/test-plan.md

**By Claude, via setup-docs skill run**

Added a test plan for the billing service covering unit, integration, and load-test coverage.

-->
