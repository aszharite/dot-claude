# rules/

Agent-agnostic behavioral rules — the `rules/` equivalent of `skills/`. A file here is a portable source of truth: plain Markdown body, no vendor-specific instructions, readable and followable by any agent regardless of tool.

Unlike `skills/`, nothing in this directory is wired into any specific agent's native config yet. That's intentional — a future `install-rules` skill will read a rule's frontmatter and generate the right tool-specific artifact (`.claude/rules/*.md`, `.cursor/rules/*.mdc`, `.devin/rules/*.md`/`.windsurf/rules/*.md`, `.github/instructions/*.instructions.md`, `.omp/rules/*.md`, etc.) for whichever conventions are present in the target repo — the same idea as `setup-docs`' multi-convention detection, applied to rules instead of docs.

## Frontmatter

Every rule file starts with two fields, kept deliberately small — just enough for an installer to pick the right native mechanism per tool, not a reimplementation of every tool's own schema:

```yaml
---
description: One sentence — what the rule does and why, written so it can stand alone as a summary if a tool only shows the description (not the full body) before deciding to load it.
trigger: always | glob | agent-requested | manual
globs: ["src/**/*.ts"] # only present when trigger: glob
---
```

- **`description`** — human/agent-facing summary. Every native format that supports on-demand or description-matched activation (Cursor's `description`, Windsurf's `model_decision` trigger, GitHub Copilot's `description`) uses this same text; installers for formats that don't (Claude Code's unconditional `.claude/rules/*.md`) can ignore it or keep it as a leading comment.
- **`trigger`** — the rule's activation mode, normalized across tools rather than copying any one tool's vocabulary:
  - `always` — unconditional, loaded into every session regardless of what's being worked on. For a genuinely universal, hard requirement (like `clarify-before-acting.md`).
  - `glob` — only relevant when files matching `globs` are touched. Requires the `globs` field.
  - `agent-requested` — the agent decides at runtime whether the rule is relevant, based on `description` alone, then loads the full body. Cheapest on context; least deterministic.
  - `manual` — only loaded when explicitly invoked/mentioned, never automatically.
- **`globs`** — list of path glob patterns. Required when `trigger: glob`, omitted otherwise.

## How a future installer should map `trigger`

| `trigger`         | Claude Code (`.claude/rules/*.md`)                                     | Cursor (`.cursor/rules/*.mdc`)            | Windsurf/Devin (`.devin/rules/*.md`) | GitHub Copilot (`.github/instructions/*.instructions.md`)                                               | omp (`.omp/rules/*.md`)                              |
| ----------------- | ---------------------------------------------------------------------- | ----------------------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `always`          | no frontmatter (unconditional load)                                    | `alwaysApply: true`                       | `trigger: always_on`                 | plain `.github/copilot-instructions.md` instead (Copilot has no per-file always-on instructions format) | `alwaysApply: true`                                  |
| `glob`            | `paths: [...]`                                                         | `globs: [...]`, `alwaysApply: false`      | `trigger: glob`, `globs: [...]`      | `applyTo: <glob>`                                                                                       | `globs: [...]`                                       |
| `agent-requested` | no native equivalent — closest fallback is a `skill` instead of a rule | `description` only (Agent Requested mode) | `trigger: model_decision`            | `description` only                                                                                      | `description` set, `alwaysApply` unset               |
| `manual`          | no native equivalent                                                   | Manual (`@rule-name`)                     | `trigger: manual`                    | no native equivalent                                                                                    | not directly supported — closest is a rulebook entry |

`AGENTS.md` itself has no stable, widely-adopted frontmatter (still proposal-stage upstream) — a rule targeting it stays plain text regardless of `trigger`.

## Current rules

Sorted by `trigger`, least restricted first (`always` → `glob` → `agent-requested` → `manual`), alphabetically by filename within each group.

| File                       | `trigger` | Purpose & context                                                                                                                                                                                                      |
| -------------------------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `address-as.md`            | `always`  | Address the user in a specific way at the start of every response. Agents sometimes lose scope of the rules over a session — a missing or wrong address is how we notice it's happened.                                |
| `clarify-before-acting.md` | `always`  | Ask about any decision the user hasn't explicitly settled, and present the full plan before acting. Agents tend to make too many decisions autonomously — validating direction first avoids wasting time backtracking. |
