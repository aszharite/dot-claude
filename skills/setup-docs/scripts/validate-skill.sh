#!/usr/bin/env bash
# validate-skill.sh — self-contained checks for the setup-docs skill itself.
#
# Usage: validate-skill.sh
#
# Run from anywhere; resolves paths relative to this script. Exits non-zero
# on first failure. Two phases:
#   1. Shared baseline checks (frontmatter, portability, evals structure) —
#      delegated to scripts/validate-skills.sh at the repo root, which is
#      the single source of truth for every skill's generic checks. Add new
#      generic rules there, not here.
#   2. Behavioral checks specific to this skill: run init.sh twice against a
#      throwaway temp dir and assert both a correct fresh scaffold and
#      idempotency on rerun.

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$SKILL_DIR/../.." && pwd)"
INIT_SH="$SKILL_DIR/scripts/init.sh"
SKILL_FOLDER_NAME="$(basename "$SKILL_DIR")"
SHARED_VALIDATOR="$REPO_ROOT/scripts/validate-skills.sh"

CATEGORIES=(product design engineering testing operations security research)

fail_count=0

pass () { echo "  PASS: $1"; }
fail () { echo "  FAIL: $1"; fail_count=$((fail_count + 1)); }

# ---------------------------------------------------------------------------
# Phase 1 — shared baseline checks (see scripts/validate-skills.sh)
# ---------------------------------------------------------------------------
echo "--- Phase 1: shared skill baseline (scripts/validate-skills.sh) ---"

if [ ! -f "$SHARED_VALIDATOR" ]; then
  fail "scripts/validate-skills.sh exists at repo root"
elif ! bash "$SHARED_VALIDATOR" "$SKILL_FOLDER_NAME"; then
  fail "shared baseline checks (scripts/validate-skills.sh) — see output above"
fi

# ---------------------------------------------------------------------------
# Phase 2 — behavioral checks (fresh run + idempotent rerun)
# ---------------------------------------------------------------------------
echo "--- Phase 2: init.sh behavior ---"

if [ ! -f "$INIT_SH" ]; then
  fail "scripts/init.sh exists"
else
  TMP_ROOT="$(mktemp -d)"
  trap 'rm -rf "$TMP_ROOT"' EXIT

  # --- fresh run ---
  bash "$INIT_SH" "$TMP_ROOT" > "$TMP_ROOT/.run1.log" 2>&1 || fail "init.sh exits 0 on fresh run"

  total_seed_files=0
  all_categories_ok=1
  for cat in "${CATEGORIES[@]}"; do
    src_dir="$SKILL_DIR/templates/$cat"
    if [ ! -d "$src_dir" ]; then
      fail "skill source templates/$cat/ exists"
      all_categories_ok=0
      continue
    fi
    while IFS= read -r src_file; do
      rel="${src_file#"$src_dir"/}"
      total_seed_files=$((total_seed_files + 1))
      if [ ! -f "$TMP_ROOT/docs/$cat/$rel" ]; then
        fail "docs/$cat/$rel created on fresh run"
        all_categories_ok=0
      fi
    done < <(find "$src_dir" -type f)
  done
  [ "$all_categories_ok" -eq 1 ] && pass "all 7 category folders seeded with every template in their source templates/ dir ($total_seed_files files total)"

  frontmatter_ok=1
  frontmatter_checked=0
  for cat in "${CATEGORIES[@]}"; do
    while IFS= read -r f; do
      frontmatter_checked=$((frontmatter_checked + 1))
      first_line="$(head -1 "$f")"
      if [ "$first_line" != "---" ]; then
        fail "$f starts with YAML frontmatter"
        frontmatter_ok=0
        continue
      fi
      if ! grep -q "^title:" "$f" || ! grep -q "^description:" "$f"; then
        fail "$f frontmatter has title and description"
        frontmatter_ok=0
      fi
    done < <(find "$TMP_ROOT/docs/$cat" -type f -name "*.md")
  done
  [ "$frontmatter_ok" -eq 1 ] && pass "all $frontmatter_checked seeded docs have valid title/description frontmatter"

  routing_ok=1
  for cat in "${CATEGORIES[@]}"; do
    routing_file="$TMP_ROOT/docs/$cat/routing.md"
    if [ ! -f "$routing_file" ]; then
      fail "docs/$cat/routing.md created on fresh run"
      routing_ok=0
    elif ! grep -q "Not finding a fit?" "$routing_file"; then
      fail "docs/$cat/routing.md has the cross-category fallback section"
      routing_ok=0
    fi
  done
  [ "$routing_ok" -eq 1 ] && pass "all 7 categories have a routing.md with the cross-category fallback section"

  if [ ! -e "$TMP_ROOT/docs/engineering/adr" ]; then
    pass "docs/engineering/adr/ left uncreated (real ADRs, not seeded)"
  else
    fail "docs/engineering/adr/ left uncreated (real ADRs, not seeded)"
  fi

  if [ -f "$TMP_ROOT/docs/README.md" ]; then
    pass "docs/README.md created"
  else
    fail "docs/README.md created"
  fi

  if [ -f "$TMP_ROOT/AGENTS.md" ] && grep -q "setup-docs:start" "$TMP_ROOT/AGENTS.md"; then
    pass "fallback AGENTS.md created with routing block (no convention present)"
  else
    fail "fallback AGENTS.md created with routing block"
  fi

  fresh_file_count="$(find "$TMP_ROOT/docs" -type f | wc -l | tr -d ' ')"

  # --- idempotent rerun ---
  bash "$INIT_SH" "$TMP_ROOT" > "$TMP_ROOT/.run2.log" 2>&1 || fail "init.sh exits 0 on rerun"

  rerun_file_count="$(find "$TMP_ROOT/docs" -type f | wc -l | tr -d ' ')"
  if [ "$fresh_file_count" = "$rerun_file_count" ]; then
    pass "docs/ file count unchanged on rerun ($rerun_file_count files)"
  else
    fail "docs/ file count unchanged on rerun (was $fresh_file_count, now $rerun_file_count)"
  fi

  marker_count="$(grep -c "setup-docs:start" "$TMP_ROOT/AGENTS.md" || true)"
  if [ "$marker_count" = "1" ]; then
    pass "no duplicate marker block in AGENTS.md after rerun"
  else
    fail "no duplicate marker block in AGENTS.md after rerun (found $marker_count)"
  fi

  # --- multi-convention detection (Tier 1 append + Tier 2 dedicated files) ---
  TMP_ROOT2="$(mktemp -d)"
  mkdir -p "$TMP_ROOT2/.cursor/rules" "$TMP_ROOT2/.clinerules"
  echo "# existing project rules" > "$TMP_ROOT2/CLAUDE.md"

  bash "$INIT_SH" "$TMP_ROOT2" > "$TMP_ROOT2/.run.log" 2>&1 || fail "init.sh exits 0 with multiple conventions present"

  if grep -q "^# existing project rules$" "$TMP_ROOT2/CLAUDE.md" && grep -q "setup-docs:start" "$TMP_ROOT2/CLAUDE.md"; then
    pass "Tier 1: existing CLAUDE.md content preserved, marker block appended"
  else
    fail "Tier 1: existing CLAUDE.md content preserved, marker block appended"
  fi

  if [ -f "$TMP_ROOT2/.cursor/rules/setup-docs.mdc" ]; then
    pass "Tier 2: .cursor/rules/setup-docs.mdc written"
  else
    fail "Tier 2: .cursor/rules/setup-docs.mdc written"
  fi

  if [ -f "$TMP_ROOT2/.clinerules/setup-docs.md" ]; then
    pass "Tier 2: .clinerules/setup-docs.md written"
  else
    fail "Tier 2: .clinerules/setup-docs.md written"
  fi

  if [ -f "$TMP_ROOT2/AGENTS.md" ]; then
    fail "no fallback AGENTS.md when other conventions are present"
  else
    pass "no fallback AGENTS.md when other conventions are present"
  fi

  rm -rf "$TMP_ROOT2"
fi

echo "---"
if [ "$fail_count" -eq 0 ]; then
  echo "All checks passed."
  exit 0
else
  echo "$fail_count check(s) failed."
  exit 1
fi
