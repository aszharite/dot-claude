#!/usr/bin/env bash
# init.sh — idempotent /docs scaffold + multi-convention agent-instructions installer
#
# Usage: init.sh <path-to-project-root>
#
# Safe to re-run: never deletes or overwrites existing docs. Only creates
# missing category folders, seeds empty folders with their starter template,
# and writes/updates its own marked block (Tier 1) or dedicated file (Tier 2)
# in every detected AI agent instruction convention.

set -euo pipefail

ROOT="${1:-.}"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES="$SKILL_DIR/templates"
DOCS_DIR="$ROOT/docs"

CATEGORIES=(product design engineering testing operations security research)
START_MARK="<!-- scaffold-docs:start -->"
END_MARK="<!-- scaffold-docs:end -->"
BLOCK_FILE="$TEMPLATES/routing-block.md"

created_dirs=()
seeded_dirs=()
skipped_dirs=()
written_targets=()

# ---------------------------------------------------------------------------
# Step 1 — /docs category folders
# ---------------------------------------------------------------------------
mkdir -p "$DOCS_DIR"

for cat in "${CATEGORIES[@]}"; do
  target="$DOCS_DIR/$cat"
  if [ ! -d "$target" ]; then
    mkdir -p "$target"
    created_dirs+=("$cat")
  fi

  # Seed only if the folder is empty (ignoring dotfiles) — never touch existing content
  if [ -z "$(ls -A "$target" 2>/dev/null)" ]; then
    src_template="$TEMPLATES/$cat"
    if [ -d "$src_template" ]; then
      cp -r "$src_template"/. "$target"/
      seeded_dirs+=("$cat")
    fi
  else
    skipped_dirs+=("$cat")
  fi
done

# docs/README.md — canonical explanation, created only if absent
if [ ! -f "$DOCS_DIR/README.md" ] && [ -f "$TEMPLATES/README.md" ]; then
  cp "$TEMPLATES/README.md" "$DOCS_DIR/README.md"
fi

# ---------------------------------------------------------------------------
# Step 2 — Tier 1: single-file conventions (append/replace marked block)
# ---------------------------------------------------------------------------
# Each entry: "path-relative-to-root"
TIER1_CANDIDATES=(
  "CLAUDE.md"
  "AGENTS.md"
  ".github/copilot-instructions.md"
  ".windsurf/rules/rules.md"
  ".windsurfrules"
  ".cursorrules"
  ".clinerules"
  "GEMINI.md"
)

write_tier1_block () {
  local file="$1"
  mkdir -p "$(dirname "$file")"
  if [ ! -f "$file" ]; then
    touch "$file"
  fi

  if grep -q "$START_MARK" "$file" 2>/dev/null; then
    awk -v start="$START_MARK" -v end="$END_MARK" -v blockfile="$BLOCK_FILE" '
      $0 ~ start { print; system("cat " blockfile); skip=1; next }
      $0 ~ end   { print; skip=0; next }
      !skip { print }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  else
    {
      echo ""
      echo "$START_MARK"
      cat "$BLOCK_FILE"
      echo "$END_MARK"
    } >> "$file"
  fi
  written_targets+=("$file")
}

tier1_found=0
for rel in "${TIER1_CANDIDATES[@]}"; do
  full="$ROOT/$rel"
  if [ -f "$full" ]; then
    write_tier1_block "$full"
    tier1_found=1
  fi
done

# ---------------------------------------------------------------------------
# Step 3 — Tier 2: directory conventions (write a dedicated, owned file)
# ---------------------------------------------------------------------------
# Each entry: "dir-relative-to-root|filename"
TIER2_CANDIDATES=(
  ".cursor/rules|scaffold-docs.mdc"
  ".clinerules|scaffold-docs.md"
  ".amazonq/rules|scaffold-docs.md"
)

tier2_found=0
for entry in "${TIER2_CANDIDATES[@]}"; do
  dir="${entry%%|*}"
  fname="${entry##*|}"
  full_dir="$ROOT/$dir"
  if [ -d "$full_dir" ]; then
    cp "$BLOCK_FILE" "$full_dir/$fname"
    written_targets+=("$full_dir/$fname")
    tier2_found=1
  fi
done

# ---------------------------------------------------------------------------
# Step 4 — Fallback: if nothing detected, create AGENTS.md
# ---------------------------------------------------------------------------
if [ "$tier1_found" -eq 0 ] && [ "$tier2_found" -eq 0 ]; then
  write_tier1_block "$ROOT/AGENTS.md"
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo "--- scaffold-docs summary ---"
echo "Created folders: ${created_dirs[*]:-none}"
echo "Seeded with templates: ${seeded_dirs[*]:-none}"
echo "Skipped (already had content): ${skipped_dirs[*]:-none}"
echo "Agent instruction files/dirs written: ${written_targets[*]:-none}"
