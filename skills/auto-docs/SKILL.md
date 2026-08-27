---
name: auto-docs
description: Diagnoses documentation drift by comparing recent project changes against what's documented and updating the affected pages. Works on any repo with a docs directory or changelog, regardless of how it was set up. Use when code changes have landed and docs may now be stale, or when the user asks to sync, refresh, or audit docs against the current state of the codebase.
---

# auto-docs

A general-purpose skill: it doesn't depend on `/docs` having been scaffolded by any particular tool (it pairs well with `setup-docs` in this repo, but doesn't require it). Given any repo, it runs a diagnostic pass — comparing what changed in the project against what's documented — and updates the affected pages so docs stay in sync with the code instead of drifting out of date.

## When to use this

- Code changes have landed in a repo with existing documentation, and that documentation may now be stale.
- The user asks to sync, refresh, audit, or diagnose docs against the current state of the codebase.

## Step 1 — Automatic or one-off?

Before asking anything, check whether automatic docs generation is already set up in this repo — every installed mechanism (Step 2 automatic, below) is written with an `auto-docs:managed` marker so this check stays a simple grep:

```bash
# Git hook
grep -l "auto-docs:managed" .git/hooks/post-commit .git/hooks/pre-push 2>/dev/null

# CI step
grep -rl "auto-docs:managed" .github/workflows .gitlab-ci.yml .circleci/config.yml 2>/dev/null

# Agent-native hook (harness-specific config, e.g. Claude Code settings)
grep -l "auto-docs:managed" .claude/settings.json 2>/dev/null
```

- **Marker found** (any of the above) → automation is already set up. Skip the question below and Step 2 (automatic) entirely — go straight to Step 2 (Choose change scope) to run this pass.
- **No marker found** → ask the user whether they want to set up automatic docs generation going forward, or just run a one-off pass right now.
  - **Automatic** → continue to Step 2 (Automatic setup) below.
  - **One-off** → skip to Step 2 (Choose change scope) below.

## Step 2 (automatic) — Choose automation mechanism

Only reached if the user chose "automatic" in Step 1. Present these options — whichever is installed must include the `auto-docs:managed` marker (a comment in the hook script or CI step, a field in the harness config) so Step 1 can detect it on future runs and skip straight past this question:

1. **Git hook** — install a local git hook (e.g. `post-commit` or `pre-push`) that triggers this skill's diagnostic against whatever was just committed/pushed, so docs get checked on every commit without a manual run.
2. **CI step** — add a step to the project's CI pipeline (GitHub Actions, GitLab CI, etc.) that runs on push or pull request, invoking an agent headlessly to diagnose drift and either commit the doc updates or flag them on the PR.
3. **Agent-native automation** — for harnesses that support their own automation hooks (e.g. Claude Code's `settings.json` hooks, or another harness's session/skill triggers), wire this skill to fire on a harness-level event instead of a git or CI event — useful when the agent harness itself, not git or CI, is the natural trigger point.

Installing the mechanism only arms it for *future* triggers — it doesn't retroactively cover drift that already exists. So once the chosen mechanism is installed and marked, ask the user whether they want to run an initial catch-up pass now to cover existing drift before the automation takes over.

- **Yes** → continue into Step 2 (one-off) for that pass, defaulting to change-scope option 3 (since the last changelog commit) so it ends up in sync with the changelog's `last_recorded_commit`, then fall through Step 3 and Step 4 as normal.
- **No** → stop here. The automation is installed and will only cover diffs going forward; any pre-existing drift stays unaddressed until the user runs this skill again or asks for the catch-up pass later.

## Step 2 (one-off) — Choose change scope

Before diagnosing anything, present the user with these four options and wait for their choice — it determines the entire diff surface the rest of this skill reasons about:

1. **Uncommitted changes** — everything staged and unstaged against `HEAD`, not yet committed: `git status --porcelain` + `git diff HEAD`.
2. **Last commit** — the diff introduced by the most recent commit: `git diff HEAD~1 HEAD` (or `git show HEAD` for full detail).
3. **Since the last changelog commit** — look for a changelog file, preferring `docs/CHANGELOG.md` then falling back to `CHANGELOG.md` at the repo root. If it has a `last_recorded_commit` frontmatter field (the `setup-docs` convention) with a real SHA, diff from there: `git diff <last_recorded_commit>..HEAD`. If the file exists but has no such field, use the commit that last touched the changelog file itself instead: `git log -1 --format=%H -- <changelog-path>`, then diff from that SHA to `HEAD`. If no changelog file exists anywhere, tell the user and offer option 2 or option 4 instead rather than guessing a range.
4. **User-specified** — let the user name the scope directly: a commit range (`<sha>..<sha>`), a branch or tag, a specific set of files/paths, or a free-text description of what changed for you to locate yourself. Get an explicit range or target before proceeding — never guess.

Don't start diagnosing or writing anything until a scope is chosen.

## Step 3 — Generate or update docs

Reached after a scope is set (Step 2 one-off) or triggered (an installed Step 2 automatic mechanism firing). Work through these in order:

1. **Locate the docs directory.** Default to `./docs`. If it doesn't exist, don't invent one — tell the user no docs directory was found and ask where documentation lives, or whether to point them at `setup-docs` to scaffold one first (auto-docs doesn't scaffold on its own; it only reads and updates what's there).
2. **Check for templates and routing tables.** If `docs/<category>/routing.md` and `docs/<category>/templates/` exist (the `setup-docs` convention), use them: pick the template whose frontmatter/section shape matches the doc being updated, so edits stay consistent with how the category is structured. If they don't exist, don't force that structure — match the format of the nearest existing doc in the same area instead.
3. **Map the changed scope to affected doc area(s).** For each changed file/path in the diff, decide which existing doc page(s) it should touch (e.g. a new API route → an API spec page, a new UI flow → a design doc, a new deploy step → a runbook). If `docs/README.md` or a category table exists, use it to route; otherwise infer from folder names already present under `docs/`. A change with no plausible doc target is reported, not forced into an unrelated page.
4. **Ask the user for additional context.** In interactive (one-off) mode, before writing anything, ask if they have supplementary material to fold in — design notes, a spec drafted elsewhere, screenshots, decisions made in conversation but not yet written down. Skip this ask in automatic (hook/CI) mode, where there's no one to prompt — proceed on the diff alone.
5. **Update the docs.** Write into the identified page(s), respecting each doc's `cadence` if its frontmatter declares one (`living` docs edit in place, `append-only` docs get a new entry, `write-once` docs get a new file rather than an edit). Base every change on the actual diff and whatever the user supplied in step 4 — never fabricate detail the diff doesn't support; if the diff's intent is ambiguous, ask rather than guess.
6. **Record it in the changelog.** If `docs/CHANGELOG.md` or root `CHANGELOG.md` exists, log the update using its existing format/attribution convention, and update its `last_recorded_commit` (or equivalent) so Step 2's "since the last changelog commit" option stays accurate next run. If no changelog exists, skip this step — don't invent one unasked.

## Step 4 — Commit the changes

If Step 3 actually wrote anything (a doc page, a template-derived new file, or the changelog entry), commit it as its own commit:

1. **Match the repo's commit style.** Inspect recent history before writing a message: `git log -10 --format='%s%n%b'`. Note the pattern — conventional-commit prefixes (`docs:`, `chore:`) vs. plain imperative sentences, typical length, whether bodies are used, ticket/issue references, emoji — and follow whatever this repo already does rather than a fixed template.
2. **Stage only what this skill wrote** — the doc page(s), any new template-derived files, and the changelog. Never `git add -A` or otherwise sweep in unrelated changes; if the scope was "uncommitted changes" (Step 2 one-off, option 1), those original source changes are the user's and stay exactly as they were, untouched by this commit.
3. **Write the message** describing what was synced and why (e.g. which change prompted the update), in the detected style — not a generic "update docs".
4. **Commit.** In one-off/interactive mode, this is a normal commit the user sees land. In automatic mode (git hook/CI), commit the same way; pushing or opening a PR, if wanted, is the automation mechanism's concern (Step 2 automatic), not this step's.
5. **Nothing to commit is not a failure.** If Step 3 made no changes (diff didn't map to any doc), skip this step and say so — don't create an empty or placeholder commit.
