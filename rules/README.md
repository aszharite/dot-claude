# rules/

Agent-agnostic behavioral rules — the `rules/` equivalent of `skills/`. A file here is a portable source of truth: plain Markdown body, no vendor-specific instructions, readable and followable by any agent regardless of tool.

Wired into agents by direct symlink, not generation: the `setup-workstation` skill symlinks each file here straight into the native rule locations it knows about — `~/.claude/rules/<file>.md` (Claude Code) and `~/.agents/rules/<file>.md` (omp's `agents` provider) — so the same file is both the portable source of truth and the thing each tool actually loads. Other tools (Cursor, Windsurf/Devin, GitHub Copilot) aren't targeted yet; the mapping table below documents what extending `setup-workstation` to them would need.

## Frontmatter

Every rule file starts with a small set of fields — enough for `setup-workstation` to symlink it correctly today, plus room for a tool that needs more (Cursor, Windsurf/Devin) without inventing a second schema later:

```yaml
---
description: One sentence — what the rule does and why, written so it can stand alone as a summary if a tool only shows the description (not the full body) before deciding to load it.
trigger: always | glob | agent-requested | manual
alwaysApply: true # present, = true, only when trigger: always — see "Compat fields" below
globs: ["src/**/*.ts"] # only present when trigger: glob
metadata:
  version: rc-1 # alpha-N | beta-N | rc-N | MAJOR.MINOR — see root README's "Versioning" section
---
```

- **`description`** — human/agent-facing summary. Every native format that supports on-demand or description-matched activation (Cursor's `description`, Windsurf's `model_decision` trigger, GitHub Copilot's `description`) uses this same text; installers for formats that don't (Claude Code's unconditional `.claude/rules/*.md`) can ignore it or keep it as a leading comment.
- **`trigger`** — the rule's activation mode, normalized across tools rather than copying any one tool's vocabulary:
  - `always` — unconditional, loaded into every session regardless of what's being worked on. For a genuinely universal, hard requirement (like `clarify-before-acting.md`).
  - `glob` — only relevant when files matching `globs` are touched. Requires the `globs` field.
  - `agent-requested` — the agent decides at runtime whether the rule is relevant, based on `description` alone, then loads the full body. Cheapest on context; least deterministic.
  - `manual` — only loaded when explicitly invoked/mentioned, never automatically.
- **`globs`** — list of path glob patterns. Required when `trigger: glob`, omitted otherwise. Doubles as the native field omp's `agents` provider and Cursor both already expect under that exact name.
- **`metadata.version`** — same shape as skills' frontmatter (nested under `metadata`, not top-level) for consistency between `rules/` and `skills/`, even though nothing forces that nesting for rules specifically. See the root README's "Versioning" section for what `alpha`/`beta`/`rc`/`MAJOR.MINOR` mean.

### Compat fields

`trigger` is our own normalized vocabulary — no real tool reads that key directly. For a rule to work once symlinked as-is (no generation step), also set whichever native field the target actually reads, alongside `trigger`, not instead of it:

- `trigger: always` → also set `alwaysApply: true`. Required for omp's `agents` provider, which has no concept of `trigger` and would otherwise silently drop the file into its on-demand rulebook bucket instead of always-apply. Claude Code doesn't need this — no `paths:` field already means unconditional load there.
- `trigger: glob` → `globs` (above) already covers omp and Cursor. Claude Code's native field for this is `paths`, not `globs` — add a `paths:` field with the same list when a `glob`-triggered rule targets Claude Code.
- `trigger: agent-requested` / `manual` — no compat field needed yet; nothing in `setup-workstation`'s current scope (Claude Code, omp) installs these differently based on extra fields.

## Mapping `trigger` per target

Claude Code and omp columns are live — `setup-workstation` symlinks straight into them. Cursor, Windsurf/Devin, and GitHub Copilot aren't targeted by any skill yet; these columns exist so extending `setup-workstation` (or a dedicated skill) later doesn't need to re-derive them.

| `trigger`         | Claude Code (`~/.claude/rules/*.md`)                                   | omp (`~/.agents/rules/*.md`)                         | Cursor (`.cursor/rules/*.mdc`)            | Windsurf/Devin (`.devin/rules/*.md`) | GitHub Copilot (`.github/instructions/*.instructions.md`)                                               |
| ----------------- | ---------------------------------------------------------------------- | ---------------------------------------------------- | ----------------------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| `always`          | no `paths:` field (unconditional load)                                 | `alwaysApply: true`                                  | `alwaysApply: true`                       | `trigger: always_on`                 | plain `.github/copilot-instructions.md` instead (Copilot has no per-file always-on instructions format) |
| `glob`            | `paths: [...]`                                                         | `globs: [...]`                                       | `globs: [...]`, `alwaysApply: false`      | `trigger: glob`, `globs: [...]`      | `applyTo: <glob>`                                                                                       |
| `agent-requested` | no native equivalent — closest fallback is a `skill` instead of a rule | `description` set, `alwaysApply` unset               | `description` only (Agent Requested mode) | `trigger: model_decision`            | `description` only                                                                                      |
| `manual`          | no native equivalent                                                   | not directly supported — closest is a rulebook entry | Manual (`@rule-name`)                     | `trigger: manual`                    | no native equivalent                                                                                    |

`AGENTS.md` itself has no stable, widely-adopted frontmatter (still proposal-stage upstream) — a rule targeting it stays plain text regardless of `trigger`.

## Current rules

Sorted by `trigger`, least restricted first (`always` → `glob` → `agent-requested` → `manual`), alphabetically by filename within each group.

| File                       | `trigger` | Version | Purpose & context                                                                                                                                                                                                      |
| -------------------------- | --------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `address-as.md`            | `always`  | `rc-1`  | Address the user in a specific way at the start of every response. Agents sometimes lose scope of the rules over a session — a missing or wrong address is how we notice it's happened.                                |
| `clarify-before-acting.md` | `always`  | `rc-1`  | Ask about any decision the user hasn't explicitly settled, and present the full plan before acting. Agents tend to make too many decisions autonomously — validating direction first avoids wasting time backtracking. |
