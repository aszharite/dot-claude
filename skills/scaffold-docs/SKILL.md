---
name: scaffold-docs
description: Scaffolds a standard /docs structure — product, design, engineering, testing, operations, security, research — with starter templates, and adds a routing table to the project's agent instruction file(s) so agents write docs to the right place. Use when starting a new project, or before writing an ad-hoc PRD, ADR, test plan, runbook, or threat model in a repo with no doc conventions yet.
---

# scaffold-docs

Creates a flat, 7-category `/docs` structure for end-to-end product development and wires it into whichever AI agent instruction convention(s) the project uses, so agents route documentation writes to the right place automatically — instead of piling everything into a README or skipping docs entirely.

This skill is not Claude-specific, in two senses. First, **the skill definition itself is portable**: it conforms to the open [Agent Skills specification](https://agentskills.io/specification) — frontmatter uses only the universal `name`/`description` fields (no Claude-Code-only extensions like `disable-model-invocation`), and every instruction is a plain bash command or a generic read/write action, never a specific tool name — so it loads and runs the same way in Codex CLI, Gemini CLI, Cursor, and any other harness that's adopted the standard (verified with the spec's own `skills-ref validate` tool). Second, **what it produces is cross-tool**: it detects whichever AI agent instruction convention(s) the repo already uses and writes to all of them. There are two kinds of convention:

- **Single-file** (append the routing block, same as before): `CLAUDE.md`, `AGENTS.md`, `.github/copilot-instructions.md`, `.windsurfrules` / `.windsurf/rules/rules.md`, legacy `.cursorrules`, `.clinerules` (file mode), `GEMINI.md`.
- **Directory-based** (write a dedicated file, not an append): `.cursor/rules/` (current Cursor format), `.clinerules/` (Cline's multi-file mode), `.amazonq/rules/` (Amazon Q Developer). These tools expect one topic per file rather than one shared instructions file, so scaffold-docs drops a `scaffold-docs.md` (or `.mdc` for Cursor) into the directory instead of appending markers.

If none of the above exist, it falls back to creating `AGENTS.md` — the broadest cross-tool default when the repo has no existing convention.

## When to use this

- Starting a new project / repo with no `/docs` directory.
- The user asks to set up, scaffold, or organize documentation.
- You (the agent) are about to write a doc — a PRD, ADR, test plan, runbook, threat model, research writeup — and the repo has no doc structure yet. Run this skill first, *then* write the doc into the correct new location.
- The user references a doc category by name ("where's our architecture decision log", "we need a threat model") and it doesn't exist yet.

Do NOT re-scaffold a repo that already has a populated `/docs` structure matching this convention — check first (Step 1). Do NOT use this for single-file doc requests unrelated to project-wide structure (e.g., "write me a README" on its own doesn't need this skill).

## The 7 categories

| Category | Purpose | Cadence | Primary agent consumer |
|---|---|---|---|
| `research` | Market research, competitive analysis, technical spikes | Write-once, archival | planning agent |
| `security` | Threat models, compliance requirements, access policies | Regulatory-driven, periodic review | security-review agent |
| `engineering` | Architecture, ADRs, API specs, data models, technical design | ADRs write-once/append-only; specs living | dev agent |
| `operations` | Deployment guides, runbooks, monitoring/alerting, incident response | Post-launch, operational | deploy/SRE agent |
| `design` | UX flows, wireframes, design system refs, accessibility notes | Iterates with product, semi-independent | design/frontend agent |
| `testing` | Test strategy, test plans, coverage criteria | Updated per feature/release | QA/test-writing agent |
| `product` | PRDs, user stories, roadmap, personas, success metrics | Living, updated every cycle | planning / product agent |

This is a flat structure — no nesting product/engineering into each other — so any agent can find its target folder in one hop without guessing which parent category it falls under.

## Routing a doc request to a template

75 templates across 7 categories — far too many to load inline here every time this skill fires. Instead, each category owns a `routing.md` sitting beside its `templates/` subfolder (`templates/<category>/routing.md` in the skill source, mirrored to `docs/<category>/routing.md` in a scaffolded project — copied automatically by Step 2's recursive copy, no special-casing needed). Each `routing.md` has a "Template | Use when... | Key sections" table for that category, plus a fallback list of the other 6 categories' `routing.md` paths.

| Category | Templates | Routing table |
|---|---|---|
| `research` | 7 | `templates/research/routing.md` → `docs/research/routing.md` |
| `security` | 14 | `templates/security/routing.md` → `docs/security/routing.md` |
| `engineering` | 14 | `templates/engineering/routing.md` → `docs/engineering/routing.md` |
| `operations` | 11 | `templates/operations/routing.md` → `docs/operations/routing.md` |
| `design` | 9 | `templates/design/routing.md` → `docs/design/routing.md` |
| `testing` | 9 | `templates/testing/routing.md` → `docs/testing/routing.md` |
| `product` | 11 | `templates/product/routing.md` → `docs/product/routing.md` |

To pick a template for a specific doc request:

1. **Identify the most likely category** using "The 7 categories" table above (purpose/cadence/consumer).
2. **Read that category's `routing.md`** and pick the template whose "Use when..." matches the request.
3. **No fit?** `routing.md` itself lists the other 6 categories' `routing.md` paths — check the next most plausible one and repeat. This is a loop, not a single hop: a request that starts looking like `engineering` might actually be a `security` doc (e.g. an incident write-up) or a `product` one (e.g. a decision log) once the first category's table doesn't match.
4. **Exhausted all 7 with nothing fitting?** Don't force a mismatched template — write the doc ad-hoc in the closest category and note the gap (it may be worth proposing a new template) rather than jamming the content into an ill-fitting structure.

Every seed filename uses the `<scope>.template.md` suffix so it self-documents as a starter, not a real doc, even outside a `templates/` folder. `templates/README.md` (→ `docs/README.md`) and `templates/routing-block.md` (the block written into `CLAUDE.md`/`AGENTS.md`/etc. — see "The routing block / dedicated file content" below) are the two skill-root-level files that aren't per-category; don't confuse `routing-block.md` (singular, cross-category, appended into the agent-instructions file) with each category's `routing.md` (per-category, lives in `docs/<category>/`).

## Frontmatter convention

Every template and every `routing.md` starts with YAML frontmatter — `title`, `description`, plus doc-specific fields. Templates carry the structured equivalent of what used to be a "> Status: ... · Owner: ... · Last updated: ..." blockquote:

- `cadence`: `living` (updated in place), `write-once` (a new file per instance, never edited — research, postmortems, one-time reviews), or `append-only` (entries added, never edited — ADRs, decision-log, tech-debt-log).
- `owner`/`author`/`reviewer`/`assessor`/`qa_lead`/`reporter`: whichever role label the original doc type used — kept distinct rather than collapsed into one generic field, since "who reviewed this" and "who owns this living policy" are different relationships worth preserving.
- `date` (write-once/point-in-time docs) or `updated` (living docs).
- `status`/`severity`/`type`/`decision`: only on templates that had an enum in the original blockquote (e.g. ADR's `Proposed | Accepted | Superseded`) — written as a default value with the rest as a YAML comment, e.g. `status: Draft  # or: In Review, Approved`.

This is a real doc-writing agent's benefit, not a routing-cost optimization — it doesn't reduce what gets loaded (a template/routing.md is read in full either way), but it makes `status`/`updated`/`owner` machine-parseable (e.g. for the optional freshness check below) instead of buried in prose, and gives any project that renders `/docs` as a site (MkDocs, Docusaurus, Jekyll, Hugo) working `title`/`description` metadata for free.

## Step 1 — Check current state (idempotency)

Before creating anything:

```bash
ls -la ./docs 2>/dev/null

# Tier 1 — single-file conventions: check for the marker block
grep -l "scaffold-docs:start" ./CLAUDE.md ./AGENTS.md ./.github/copilot-instructions.md \
  ./.windsurfrules ./.windsurf/rules/rules.md ./.cursorrules ./.clinerules ./GEMINI.md 2>/dev/null

# Tier 2 — directory conventions: check whether scaffold-docs already dropped its file
ls ./.cursor/rules/scaffold-docs.mdc ./.clinerules/scaffold-docs.md ./.amazonq/rules/scaffold-docs.md 2>/dev/null
```

- If `/docs` already has all 7 category folders **and** every detected convention file/directory already has its scaffold-docs entry → the repo is already scaffolded. Tell the user, and don't touch anything unless they explicitly ask to re-run or update it.
- If `/docs` exists but is missing some categories (e.g., someone already made `docs/product` by hand) → only create what's missing. Never overwrite or delete existing docs.
- If a *new* convention file/directory appears that wasn't there on a previous run (e.g. the user added Cursor after initially only having `CLAUDE.md`) → write to the newly-detected one too; don't skip it just because other conventions are already scaffolded.
- If none exist → proceed fresh.

## Step 2 — Run the scaffold script

```bash
bash scripts/init.sh <path-to-project-root>
```

This script (see `scripts/init.sh`):
1. Creates the 7 category folders under `<root>/docs/` if missing (safe on partial structures — never deletes or overwrites existing files).
2. Copies the matching starter templates and `routing.md` from `templates/<category>/` into each folder **only if that folder is empty** — never overwrites an existing doc.
3. Detects every AI agent instruction convention present in the repo, checked in this order:
   - **Tier 1 (single-file, append block):** `CLAUDE.md`, `AGENTS.md`, `.github/copilot-instructions.md`, `.windsurf/rules/rules.md` or `.windsurfrules`, `.cursorrules` (legacy Cursor), `.clinerules` (file mode), `GEMINI.md`.
   - **Tier 2 (directory, drop a dedicated file):** `.cursor/rules/` → `scaffold-docs.mdc`; `.clinerules/` → `scaffold-docs.md`; `.amazonq/rules/` → `scaffold-docs.md`.
   - Writes to **every** convention found, not just the first — a repo using both Claude Code and Cursor should get both updated. If none are found, it creates `AGENTS.md`.
4. For Tier 1 targets: inserts or replaces the routing block, delimited by `<!-- scaffold-docs:start -->` / `<!-- scaffold-docs:end -->` markers, so re-running the skill updates the routing table cleanly without duplicating it. For Tier 2 targets: writes (or overwrites, since it's a scaffold-docs-owned file) the dedicated `scaffold-docs.md`/`.mdc` file containing the same routing content.

Run it, then report back to the user exactly which folders/files were created vs. already present, and which convention(s) were written to — don't claim to have created something that already existed.

## Step 3 — Verify

After running:
- List `./docs` recursively (e.g. `find ./docs -type f`) to confirm the 7 folders exist with their seed templates and a `routing.md` in each.
- Read each detected convention file (e.g. `CLAUDE.md`, `AGENTS.md`) or dedicated file (e.g. `.cursor/rules/scaffold-docs.mdc`) to confirm it was written correctly and, for Tier 1 files, that the marker block isn't duplicated.

**If verification fails** — a category folder is missing, a marker block is duplicated, or a Tier 2 file wasn't written — don't report success. Re-check which convention files actually exist in the repo (Step 1's detection commands) and re-run Step 2; if the same failure recurs, stop and tell the user what's wrong rather than silently leaving a half-scaffolded repo.

## Step 4 — Write into it (if this was triggered by an in-flight doc request)

If you ran this skill because you were about to write a specific doc (a PRD, an ADR, etc.), use the category's `routing.md` to pick the right template (see "Routing a doc request to a template" above), then write that doc into the correct category folder using the seeded template as your starting structure — fill in its frontmatter placeholders (`owner`/`author`, `date`/`updated`, `status`, etc.) along with the body, don't leave `<name>`/`<date>` literal in the real doc. Don't leave the user with just an empty scaffold when they actually asked for content.

## The routing block / dedicated file content

The routing table is the actual behavior-changing artifact — the folders alone are just discoverability. For Tier 1 conventions, this block gets appended into the detected file (e.g. `CLAUDE.md`, `AGENTS.md`); for Tier 2 conventions, the same content becomes the entire contents of the dedicated file (e.g. `.cursor/rules/scaffold-docs.mdc`). See `templates/routing-block.md` for the exact content — it's identical regardless of which convention it lands in:

```
<!-- scaffold-docs:start -->
## Project documentation

Full conventions & full template catalog (75 templates across 7 categories): /docs/README.md

| When you're... | Write/update... | Template |
|---|---|---|
| researching market/users before scoping | /docs/research/ | docs/research/templates/spike.template.md |
| defining what to build | /docs/product/prd.md (+ user stories) | docs/product/templates/prd.template.md |
| designing flows/UI | /docs/design/ | docs/design/templates/flow-spec.template.md |
| making an architectural decision | /docs/engineering/adr/NNNN-title.md | docs/engineering/templates/adr.template.md |
| writing/updating an API or data contract | /docs/engineering/api-spec.md | docs/engineering/templates/api-spec.template.md |
| defining how a feature will be tested | /docs/testing/test-plan.md | docs/testing/templates/test-plan.template.md |
| writing deploy steps or on-call procedures | /docs/operations/runbook.md | docs/operations/templates/runbook.template.md |
| assessing threats/compliance for a feature | /docs/security/threat-model.md | docs/security/templates/threat-model.template.md |

Each category has more scenario-specific templates than shown above (e.g. security also has compliance-checklist, incident-response-plan, vulnerability-assessment; engineering also has rfc, tech-design, data-contract) — check `/docs/<category>/templates/` or `/docs/README.md` when the doc you need isn't one of the 8 above.
<!-- scaffold-docs:end -->
```

The 8 rows above stay fixed regardless of catalog growth — it's read on every turn, so it only surfaces the single most load-bearing template per category plus a pointer to the rest. Category explanations, the full template list, and writing guidance live in `/docs/README.md`, which agents read on-demand, not inline in the agent instruction file(s).

## Optional — freshness check

If the user wants doc staleness enforcement (not created by default — ask first), a lightweight `/docs-check` pattern is: given recently changed code paths, check whether the corresponding category doc (e.g. new API route → `engineering/api-spec.md`, new feature → `product/prd.md` + `testing/test-plan.md`) was touched in the same change set, and flag it if not. Real docs now carry an `updated:`/`date:` frontmatter field (see "Frontmatter convention" above), so this can be a `grep`/parse over frontmatter instead of relying on file mtimes or prose-parsing. This is a nudge, not a hard gate — surface it as a suggestion, don't block work on it.

## Notes

- Never delete or overwrite a user's existing docs. All operations are additive/idempotent.
- If the project has a strong reason to deviate from the 7 categories (e.g., a pure infra repo with no "product" surface), say so and propose a trimmed set rather than forcing all 7 — confirm with the user before dropping a category.
- The `docs/README.md` created by the script is the canonical explanation of the structure; keep every convention's block/file as a thin pointer to it.
- Tier 2 dedicated files (`.cursor/rules/scaffold-docs.mdc`, etc.) are considered scaffold-docs-owned — safe to overwrite on re-run, unlike Tier 1 files where scaffold-docs only ever touches its own marked block and leaves the rest of the file alone.
- If the user's setup uses a convention this skill doesn't detect yet, tell them which file/directory wasn't picked up and ask whether to add it, rather than silently skipping it.
- **Portability guardrail**: don't introduce Claude-Code-only frontmatter fields (e.g. `disable-model-invocation`) or instructions phrased as invoking a specific tool by name — describe the action instead (e.g. "run `X`" or "read `Y`") — this is what keeps the skill definition itself loadable by any harness that's adopted the open Agent Skills spec, not just Claude. Re-run `npx skills-ref validate .` after editing this file.
