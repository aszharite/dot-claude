---
title: "Documentation Changelog"
description: Append-only log of changes to files under /docs, most recent date first.
cadence: append-only
last_recorded_commit: none yet  # short SHA of the most recent entry below; a staleness/diff tool compares this against `git log -- docs/` to find undocumented doc changes
---

# Documentation Changelog

Tracks changes to files anywhere under `/docs` — not the product's own changelog (see `product/release-notes.template.md` for that, which is user-facing). Whenever an agent or a human adds, edits, removes, or renames a file under `/docs` — including this file's own category and this file itself — record it here in the same change set as the doc change.

- **Structure**: each date is an `##` heading (`YYYY-MM-DD`), most recent date first, directly below this list. Each changed file under that date is a `###` heading, using its path relative to the repo root. Under a file heading, each change is a `**By ...**` attribution line (with commit SHA(s)) followed by a one-paragraph summary.
- **New date**: if today isn't already the first `##` heading in the file, add a new one at the very top of the log (directly below this list), then add the file's `###` heading under it.
- **Same day, same file**: if today's `##` date and this file's `###` heading both already exist, append another `**By ...**` + summary pair under that existing heading instead of duplicating it.
- **Same day, different file**: add a new `###` heading for the file under today's existing `##` date section.
- **Different day, same file**: the file gets a fresh `###` heading under the new day's `##` section — the same path appearing under multiple dates is expected, not a duplicate.
- **Attribution**: `**By <name>**` for a human editing directly. An agent entry is never bare — it always carries context for what drove it: `**By <agent>, obo <name>**` when a specific person asked for the change (the common case), or `**By <agent>, via <trigger>**` when something other than a direct request drove it — a scheduled/CI job, a lint or freshness check, another automation — naming that trigger (e.g. `By Claude, via nightly freshness check`, `By Codex CLI, via PR #482 review`). Never write a plain `**By Claude**` or `**By Agent**` with no `obo`/`via`.
- **Commit SHA(s)**: a change is one coherent edit to one file for one reason, no matter how many commits it took to get there (WIP commits, fixups, iterating mid-session) — that's still a single entry, not one entry per commit. List every commit that contributed, oldest first, comma-separated, in parens after the attribution: `**By <attribution>** (`sha1`, `sha2`, `sha3`)`. Don't log an entry until the change is actually done — logging every intermediate commit as its own entry just adds noise. To find the range: `git log --format=%h <last_recorded_commit>..HEAD -- <file>` lists every commit since the changelog last caught up that touched this file; take the ones belonging to this change — if unrelated commits from someone else are mixed into that range, those get their own entry (see "Same day, same file" / "Different day, same file" above), not a shared SHA list. A commit doesn't exist yet while you're still editing, so this is necessarily a follow-up step: finish committing the actual doc/content change(s) first, then add or finalize the changelog entry — with the real SHA(s) — as its own small follow-up commit. Never invent a SHA; if the change genuinely isn't committed yet, write `(uncommitted)` and correct it once it is.
- **Frontmatter sync**: `last_recorded_commit` in this file's frontmatter always mirrors the SHA on the newest entry (the one under the topmost `##`/`###` headings) — update both in the same edit. A diff/staleness tool reads it to run `git log <last_recorded_commit>..HEAD -- docs/` and see what's changed since this changelog was last caught up.
- **Summary**: one paragraph — enough for someone skimming months later to know whether to open the file. This can carry more detail than a one-line entry since a heading-scoped change may be substantial.
- **Append-only**: never edit or delete a past entry. A later revert gets its own new `**By ...**` + summary entry, not an edit to the original.

<!-- Example of the shape once entries exist (same day: one file touched by two people across separate changes, one of those changes spanning three iterative commits; a second file touched once):

## 2026-08-25

### docs/engineering/adr/0001-use-postgres.md

**By Claude, obo Jane Doe** (`a1b2c3d`)

Added an ADR recording the decision to use Postgres over DynamoDB for the billing service, including the rejected alternatives and the rationale.

**By Jane Doe** (`e4f5a6b`, `f6a7b8c`, `a8b9c0d`)

Reworked the consequences section after review feedback — took a few passes to land on wording everyone agreed with, hence the three commits.

### docs/testing/test-plan.md

**By Claude, via setup-docs skill run** (`9c8d7e6`)

Added a test plan for the billing service covering unit, integration, and load-test coverage.

-->
