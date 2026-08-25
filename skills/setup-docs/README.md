# setup-docs

An [Agent Skill](https://agentskills.io/specification) that scaffolds a standard `/docs` directory for a project and wires it into whatever AI-agent-instructions convention the repo already uses, so agents write documentation to a predictable place instead of piling everything into a README or skipping it entirely.

## Why this exists

Agents write ad-hoc docs when asked — a PRD here, an incident writeup there — with no consistent home, naming, or frontmatter, and nothing tells the *next* agent where to look or write. This skill fixes that once per repo: a flat, 7-category `/docs` tree, 75 starter templates so an agent isn't inventing structure from scratch, and a routing table injected into the project's own agent-instructions file (`CLAUDE.md`, `AGENTS.md`, Cursor rules, etc.) so the convention is enforced on every future turn, not just while this skill is active.

## What it does, briefly

- Creates `docs/{product,design,engineering,testing,operations,security,research}/`, each seeded with that category's starter templates and a `routing.md` for picking the right one.
- Creates `docs/README.md` (the human-facing explanation of the structure) and `docs/CHANGELOG.md` (an append-only log of who changed which doc and why — see [Skills changelog](#skills-changelog-plumbing) below).
- Detects every agent-instructions convention present in the target repo (Tier 1: `CLAUDE.md`, `AGENTS.md`, Copilot, Windsurf, `.cursorrules`, `.clinerules`, `GEMINI.md` — Tier 2: `.cursor/rules/`, `.clinerules/`, `.amazonq/rules/`) and writes a routing block/dedicated file into *every* one found, falling back to `AGENTS.md` if none exist.
- Everything is additive and idempotent: re-running never deletes, overwrites, or duplicates existing docs or marker blocks.

The full behavioral spec — exact steps, detection order, verification, the routing block's literal contents — lives in `SKILL.md`; this file is orientation for a human browsing the repo, not a second copy of it.

## Layout

| Path | Purpose |
|---|---|
| `SKILL.md` | The skill definition an agent reads to run this — triggers, step-by-step procedure, routing-block content. |
| `scripts/init.sh` | The idempotent scaffold script `SKILL.md` invokes. |
| `scripts/validate-skill.sh` | Self-test suite for this skill (frontmatter, `init.sh` behavior, idempotency). |
| `templates/<category>/` | One folder per doc category, each holding its seed templates plus a `routing.md`. |
| `templates/README.md`, `templates/CHANGELOG.md`, `templates/routing-block.md` | Root-level files copied/written into the *target* project, not this repo — they become `docs/README.md`, `docs/CHANGELOG.md`, and the block appended to the target's `CLAUDE.md`/`AGENTS.md`/etc. |
| `evals/evals.json` | Scenario-based evals for judging whether an agent invoked and used this skill correctly. |

## Skills-changelog plumbing

`docs/CHANGELOG.md`, once scaffolded into a project, is a standing rule (carried by the routing block into that project's own agent-instructions file) that every future doc edit under `/docs` — by a human or an agent — gets logged there: date, file, who (or what automation) drove the change, the commit SHA(s) that made it, one-paragraph summary. The file's own frontmatter tracks `last_recorded_commit`, the SHA of the newest logged entry — a separate skill or tool can diff from that SHA to `HEAD` on `docs/` to detect drift (doc changes nobody logged) or generate the missing entries. That log lives in the *target* project, not here; `templates/CHANGELOG.md` in this repo is only the seed.

## Portability

The skill definition itself targets the open Agent Skills spec, not just Claude Code: no Claude-Code-only frontmatter (e.g. `disable-model-invocation`), and every instruction describes an action rather than naming a specific tool, so it should load the same way in Codex CLI, Gemini CLI, Cursor, or any other compliant harness. Re-validate after edits:

```bash
npx skills-ref validate skills/setup-docs
```

## Using it

Not invoked by name — a compliant agent matches it automatically: starting a new project with no `/docs`, being asked to set up/organize documentation, or being about to write an ad-hoc PRD/ADR/runbook/threat-model into a repo with no doc structure yet. See "When to use this" in `SKILL.md` for the exact trigger conditions.
