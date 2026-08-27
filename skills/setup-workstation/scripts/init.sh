#!/usr/bin/env bash
# init.sh — idempotent workstation bootstrap: symlinks this repo's configs,
# rules, and skills into the native locations each OS/tool actually reads.
#
# Usage: init.sh [home-dir-override]
#
# With no argument, targets the real home directory ($HOME, falling back to
# $USERPROFILE converted via cygpath on Windows git-bash where $HOME is
# often unset). An explicit argument overrides the target home directory —
# used by validate-skill.sh to test against a throwaway sandbox instead of
# the real machine.
#
# Safe to re-run: never overwrites a real (non-symlink) file or directory
# that already exists at a target path — only creates missing links or
# repairs a symlink that points somewhere else.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$SKILL_DIR/../.." && pwd)"

# ---------------------------------------------------------------------------
# OS detection
# ---------------------------------------------------------------------------
case "$(uname -s)" in
  Darwin) OS=mac ;;
  MINGW*|MSYS*|CYGWIN*|*_NT*) OS=win ;;
  *)
    echo "Unsupported OS for setup-workstation: $(uname -s)" >&2
    echo "Only Windows (git-bash/MSYS) and Mac (Darwin) are supported." >&2
    exit 1
    ;;
esac

# ---------------------------------------------------------------------------
# Target home directory
# ---------------------------------------------------------------------------
if [ "$#" -ge 1 ]; then
  HOME_DIR="$1"
elif [ -n "${HOME:-}" ]; then
  HOME_DIR="$HOME"
elif [ "$OS" = "win" ] && [ -n "${USERPROFILE:-}" ]; then
  HOME_DIR="$(cygpath -u "$USERPROFILE")"
else
  echo "Could not determine home directory (\$HOME and \$USERPROFILE both unset)." >&2
  exit 1
fi
mkdir -p "$HOME_DIR"
HOME_DIR="$(cd "$HOME_DIR" && pwd)"

linked=()
skipped=()
missing_sources=()

# link SRC DEST — SRC must exist (file or dir). Skips if DEST is already a
# symlink resolving to SRC. Refuses to touch DEST if it exists and is not a
# symlink (a real file/dir there is the user's, never overwritten).
link() {
  local src="$1" dest="$2"
  if [ ! -e "$src" ]; then
    missing_sources+=("$src")
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    if [ "$(realpath "$dest" 2>/dev/null || true)" = "$(realpath "$src")" ]; then
      skipped+=("$dest (already linked to $src)")
      return
    fi
    rm -f "$dest"
  elif [ -e "$dest" ]; then
    skipped+=("$dest (real file/dir already exists there, not touching)")
    return
  fi

  if [ "$OS" = "win" ]; then
    local win_src win_dest
    win_src="$(cygpath -w "$src")"
    win_dest="$(cygpath -w "$dest")"
    powershell -NoProfile -Command \
      "New-Item -ItemType SymbolicLink -Path '$win_dest' -Target '$win_src' | Out-Null"
  else
    ln -s "$src" "$dest"
  fi
  linked+=("$dest -> $src")
}

# ---------------------------------------------------------------------------
# omp config: OS-specific file, same target path on both OSes
# ---------------------------------------------------------------------------
case "$OS" in
  win)  link "$REPO_ROOT/.omp/config.win.yml" "$HOME_DIR/.omp/agent/config.yml" ;;
  mac)  link "$REPO_ROOT/.omp/config.mac.yml" "$HOME_DIR/.omp/agent/config.yml" ;;
esac

# ---------------------------------------------------------------------------
# Claude / agents context files (OS-agnostic content)
# ---------------------------------------------------------------------------
link "$REPO_ROOT/.claude/CLAUDE.md" "$HOME_DIR/.claude/CLAUDE.md"
link "$REPO_ROOT/.agents/AGENTS.md" "$HOME_DIR/.agents/AGENTS.md"

# ---------------------------------------------------------------------------
# Rules: every rules/*.md (except README.md) into each native rules/ dir
# ---------------------------------------------------------------------------
shopt -s nullglob
for rule_file in "$REPO_ROOT"/rules/*.md; do
  name="$(basename "$rule_file")"
  [ "$name" = "README.md" ] && continue
  link "$rule_file" "$HOME_DIR/.claude/rules/$name"
  link "$rule_file" "$HOME_DIR/.agents/rules/$name"
done

# ---------------------------------------------------------------------------
# Skills: every skills/<name>/ directory into each native skills/ dir
# ---------------------------------------------------------------------------
for skill_dir in "$REPO_ROOT"/skills/*/; do
  skill_dir="${skill_dir%/}"
  name="$(basename "$skill_dir")"
  link "$skill_dir" "$HOME_DIR/.claude/skills/$name"
  link "$skill_dir" "$HOME_DIR/.agents/skills/$name"
done

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo "--- setup-workstation summary (OS: $OS, home: $HOME_DIR) ---"
echo "Linked:"
printf '  %s\n' "${linked[@]:-(none)}"
echo "Already linked (skipped):"
printf '  %s\n' "${skipped[@]:-(none)}"
if [ "${#missing_sources[@]}" -gt 0 ]; then
  echo "Missing sources (not linked):"
  printf '  %s\n' "${missing_sources[@]}"
fi
