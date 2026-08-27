#!/usr/bin/env bash
# validate-skill.sh — self-contained checks for the setup-workstation skill.
#
# Usage: validate-skill.sh
#
# Run from anywhere; resolves paths relative to this script. Two phases:
#   1. Shared baseline checks (frontmatter, portability, evals structure) —
#      delegated to scripts/validate-skills.sh at the repo root.
#   2. Behavioral checks: run init.sh twice against a throwaway sandbox
#      home directory (never the real machine) and assert a correct fresh
#      link set, idempotency on rerun, and that a real file at a target
#      path is never overwritten.

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$SKILL_DIR/../.." && pwd)"
INIT_SH="$SKILL_DIR/scripts/init.sh"
SKILL_FOLDER_NAME="$(basename "$SKILL_DIR")"
SHARED_VALIDATOR="$REPO_ROOT/scripts/validate-skills.sh"

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
# Phase 2 — behavioral checks (fresh run + idempotent rerun + no clobber)
# ---------------------------------------------------------------------------
echo "--- Phase 2: init.sh behavior ---"

if [ ! -f "$INIT_SH" ]; then
  fail "scripts/init.sh exists"
else
  SANDBOX="$(mktemp -d)"
  trap 'rm -rf "$SANDBOX"' EXIT

  # --- fresh run ---
  bash "$INIT_SH" "$SANDBOX" > "$SANDBOX/.run1.log" 2>&1 || fail "init.sh exits 0 on fresh run"

  expected_targets=(
    ".claude/CLAUDE.md"
    ".agents/AGENTS.md"
  )
  all_ok=1
  for rel in "${expected_targets[@]}"; do
    if [ ! -L "$SANDBOX/$rel" ]; then
      fail "$rel is a symlink after fresh run"
      all_ok=0
    fi
  done
  [ "$all_ok" -eq 1 ] && pass "CLAUDE.md and AGENTS.md symlinked on fresh run"

  omp_config_ok=1
  if [ ! -L "$SANDBOX/.omp/agent/config.yml" ]; then
    fail ".omp/agent/config.yml is a symlink after fresh run"
    omp_config_ok=0
  fi
  [ "$omp_config_ok" -eq 1 ] && pass ".omp/agent/config.yml symlinked to an OS-specific config file"

  rules_ok=1
  rule_count=0
  for rule_file in "$REPO_ROOT"/rules/*.md; do
    name="$(basename "$rule_file")"
    [ "$name" = "README.md" ] && continue
    rule_count=$((rule_count + 1))
    for target_dir in ".claude/rules" ".agents/rules"; do
      if [ ! -L "$SANDBOX/$target_dir/$name" ]; then
        fail "$target_dir/$name is a symlink after fresh run"
        rules_ok=0
      fi
    done
  done
  [ "$rules_ok" -eq 1 ] && pass "all $rule_count rule file(s) symlinked into both .claude/rules and .agents/rules"

  skills_ok=1
  skill_count=0
  for skill_dir in "$REPO_ROOT"/skills/*/; do
    skill_dir="${skill_dir%/}"
    name="$(basename "$skill_dir")"
    skill_count=$((skill_count + 1))
    for target_dir in ".claude/skills" ".agents/skills"; do
      if [ ! -L "$SANDBOX/$target_dir/$name" ]; then
        fail "$target_dir/$name is a symlink after fresh run"
        skills_ok=0
      fi
    done
  done
  [ "$skills_ok" -eq 1 ] && pass "all $skill_count skill(s) symlinked into both .claude/skills and .agents/skills"

  # Content resolves correctly through the link (catches an MSYS-style
  # target path that exists but doesn't actually resolve).
  if [ -f "$SANDBOX/.claude/CLAUDE.md" ] && grep -q "Project rules" "$SANDBOX/.claude/CLAUDE.md" 2>/dev/null; then
    pass "linked CLAUDE.md resolves to real content, not a broken link"
  else
    fail "linked CLAUDE.md resolves to real content, not a broken link"
  fi

  # --- idempotent rerun ---
  bash "$INIT_SH" "$SANDBOX" > "$SANDBOX/.run2.log" 2>&1 || fail "init.sh exits 0 on rerun"
  if grep -q "^Linked:$" "$SANDBOX/.run2.log" && ! grep -A1 "^Linked:$" "$SANDBOX/.run2.log" | grep -q " -> "; then
    pass "rerun links nothing new (fully idempotent)"
  else
    fail "rerun links nothing new (fully idempotent)"
  fi

  # --- never clobber a real file ---
  SANDBOX2="$(mktemp -d)"
  mkdir -p "$SANDBOX2/.claude"
  echo "# pre-existing hand-written content" > "$SANDBOX2/.claude/CLAUDE.md"
  bash "$INIT_SH" "$SANDBOX2" > "$SANDBOX2/.run.log" 2>&1 || fail "init.sh exits 0 when a real file blocks a target"
  if [ -L "$SANDBOX2/.claude/CLAUDE.md" ]; then
    fail "pre-existing real CLAUDE.md is left untouched, not replaced with a symlink"
  else
    content="$(cat "$SANDBOX2/.claude/CLAUDE.md")"
    if [ "$content" = "# pre-existing hand-written content" ]; then
      pass "pre-existing real CLAUDE.md is left untouched, not replaced with a symlink"
    else
      fail "pre-existing real CLAUDE.md is left untouched, not replaced with a symlink"
    fi
  fi
  rm -rf "$SANDBOX2"
fi

echo "---"
if [ "$fail_count" -eq 0 ]; then
  echo "All checks passed."
  exit 0
else
  echo "$fail_count check(s) failed."
  exit 1
fi
