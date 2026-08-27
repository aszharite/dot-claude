# setup-workstation

An [Agent Skill](https://agentskills.io/specification) that symlinks this repo's own configs, rules, and skills into the native locations Windows or Mac actually read, so a workstation is always in sync with the repo instead of drifting out of it. Unlike `setup-docs`/`auto-docs`, this skill is not portable to other repos — it's specific to this repo's own layout.

## Why this exists

A dotfiles-style repo is only useful if the machine actually reads it, not just stores it. Without this skill, keeping `~/.claude/CLAUDE.md`, `~/.agents/AGENTS.md`, `~/.omp/agent/config.yml`, every rule under `rules/`, and every skill under `skills/` in sync with this repo across two workstations means manually copying files and remembering to redo it after every change. This skill makes the repo the single source of truth: real symlinks, not copies, so an edit here is live everywhere it's linked, on every workstation, immediately.

## What it does, briefly

- Detects the OS (`Darwin` → Mac, `MINGW*`/`MSYS*`/`CYGWIN*`/`*_NT*` → Windows) and links the matching `.omp/config.win.yml` or `.omp/config.mac.yml` to `~/.omp/agent/config.yml`.
- Links `.claude/CLAUDE.md` → `~/.claude/CLAUDE.md` and `.agents/AGENTS.md` → `~/.agents/AGENTS.md`.
- Links every `rules/*.md` (except `README.md`) into both `~/.claude/rules/` and `~/.agents/rules/` — the native, always-loaded rule locations for Claude Code and omp respectively.
- Links every `skills/<name>/` directory into both `~/.claude/skills/<name>/` and `~/.agents/skills/<name>/`.
- Everything is additive and idempotent: never overwrites a real (non-symlink) file or directory already at a target path; a symlink pointing at the wrong place gets repaired, a correct one is left alone.

The full behavioral spec — exact mapping table, OS-detection details, the Windows symlink gotchas that ruled out `mklink`/`ln -s` in favor of PowerShell — lives in `SKILL.md`; this file is orientation for a human browsing the repo, not a second copy of it.

## Layout

| Path                        | Purpose                                                                                                                                                 |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `SKILL.md`                  | The skill definition — mapping table, step-by-step procedure, verification steps.                                                                       |
| `scripts/init.sh`           | The idempotent, OS-detecting symlink script `SKILL.md` invokes. Accepts an optional home-directory override for sandboxed testing.                      |
| `scripts/validate-skill.sh` | Self-test suite (frontmatter, `init.sh` behavior, idempotency, real-file protection) — always runs against a throwaway sandbox, never the real machine. |

## Portability

The skill definition itself still targets the open Agent Skills spec (no Claude-Code-only frontmatter, no tool-name-specific instructions), even though what it _does_ is specific to this one repo. Re-validate after edits:

```bash
npx skills-ref validate skills/setup-workstation
```

## Using it

Not invoked by name — a compliant agent matches it automatically: setting up a new Windows or Mac workstation for this repo, or after a rule/skill was added and hasn't been linked in yet. See "When to use this" in `SKILL.md` for the exact trigger conditions.

Running it links against the real machine (`~/.claude`, `~/.agents`, `~/.omp`) — not something to run casually mid-development the way `validate-skill.sh`'s sandboxed tests can be.
