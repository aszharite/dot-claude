---
name: setup-workstation
description: Symlinks this repo's omp config, Claude config, agent config, rules, and skills into the native locations each OS and tool actually reads, so a workstation stays in sync with the repo instead of drifting. Use when setting up a new Windows or Mac workstation for this repo, or after adding/renaming a rule or skill that hasn't been linked in yet.
---

# setup-workstation

Bootstraps a workstation from this repo: creates real symlinks from each native config/rule/skill location on the machine back into the file this repo actually tracks, so editing the repo is the only thing that's ever needed — no separate step to keep a workstation's live config in sync with it.

Unlike `setup-docs`/`auto-docs`, this skill is not portable to other repos — it's specific to this repo's own layout (`.omp/config.win.yml`/`config.mac.yml`, `.claude/CLAUDE.md`, `.agents/AGENTS.md`, `rules/`, `skills/`).

## When to use this

- Setting up a new Windows or Mac workstation for this repo for the first time.
- A rule or skill was just added/renamed and hasn't been linked into the native locations yet.
- The user asks to sync, link, or install the workstation config.

## What gets linked, and where

| Source (this repo)                                             | Target                                                          | Notes                                                                                                                                                                                                                                                           |
| -------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.omp/config.win.yml` (Windows) or `.omp/config.mac.yml` (Mac) | `~/.omp/agent/config.yml`                                       | OS-detected — only the matching file is linked.                                                                                                                                                                                                                 |
| `.claude/CLAUDE.md`                                            | `~/.claude/CLAUDE.md`                                           | Same file on every OS.                                                                                                                                                                                                                                          |
| `.agents/AGENTS.md`                                            | `~/.agents/AGENTS.md`                                           | Same file on every OS.                                                                                                                                                                                                                                          |
| Each `rules/*.md` (except `README.md`)                         | `~/.claude/rules/<file>.md` **and** `~/.agents/rules/<file>.md` | Direct symlink of the same file into both native rule locations — see `rules/README.md`'s "Compat fields" for why each rule's frontmatter carries both the repo's own `trigger` field and whatever native field (e.g. `alwaysApply`) the target actually reads. |
| Each `skills/<name>/` directory                                | `~/.claude/skills/<name>/` **and** `~/.agents/skills/<name>/`   | Whole-directory symlink; both Claude Code and omp's `agents` provider follow directory symlinks and load `SKILL.md` from the target.                                                                                                                            |

Cursor, Windsurf/Devin, and GitHub Copilot are not targeted — this repo doesn't use them, and `rules/README.md`'s mapping table documents what adding them here would need.

## Step 1 — Check current state (idempotency)

`scripts/init.sh` is itself idempotent (see Step 2) — it never overwrites a real file or directory, only creates a missing symlink or repairs one pointing at the wrong target. There's no separate pre-check needed before running it; running it on an already-linked workstation is a safe no-op that reports everything as already linked.

## Step 2 — Run the script

```bash
bash scripts/init.sh
```

This detects the OS (`Darwin` → Mac, `MINGW*`/`MSYS*`/`CYGWIN*`/`*_NT*` → Windows) and the real home directory (`$HOME`, falling back to `$USERPROFILE` via `cygpath` when `$HOME` is unset, which happens on some Windows git-bash setups), then links everything in the table above.

- On Windows, symlinks are created via `New-Item -ItemType SymbolicLink` in PowerShell, not `ln -s` or `mklink` invoked through a nested shell — both were tried and failed in practice: `cmd /c mklink` didn't reliably execute when invoked from a nested bash, and `ln -s` created a real NTFS symlink but with an MSYS-style target path (`/d/...`) that native (non-MSYS) tools couldn't resolve. PowerShell with `cygpath -w`-converted paths on both sides is what actually works.
- On Mac, plain `ln -s` is sufficient (real POSIX symlinks, no path-translation issue).
- A target that's already a symlink pointing at the correct source is left alone. A target that's a symlink pointing somewhere else is replaced. A target that's a real (non-symlink) file or directory is never touched — reported as skipped instead.

Report back exactly what was linked vs. already-linked vs. skipped-because-a-real-file-exists — don't claim to have linked something that was already there.

## Step 3 — Verify

- Read one of the newly-linked files back from its target path (e.g. `~/.claude/rules/clarify-before-acting.md`) to confirm it resolves to the repo content, not just that a symlink object exists — a Windows symlink can exist but fail to resolve if the target path is malformed (see the `ln -s` caveat above).
- On Windows specifically, confirm with `Get-Item <path> | Select LinkType, Target` that `LinkType` is `SymbolicLink` and `Target` is a proper Windows path (a drive letter and backslashes), not an MSYS-style path.

**If verification fails** — a symlink exists but doesn't resolve, or `Target` looks like a POSIX path on Windows — don't report success. Remove the broken link and re-run Step 2 rather than leaving a half-linked workstation.

## Notes

- Never overwrite a real file/directory at a target path — if the user already has hand-written content at, say, `~/.claude/CLAUDE.md`, stop and ask rather than silently replacing it with a symlink.
- This skill only creates symlinks; it never edits the content of any repo file. Content changes to rules/skills/configs happen through normal edits to this repo, which every already-linked workstation then sees automatically.
- Re-run this after adding a new file under `rules/` or a new directory under `skills/` — nothing watches for new files automatically.
