#!/usr/bin/env bash
# validate-skills.sh — baseline best-practices check for every skill in this repo.
#
# Usage: scripts/validate-skills.sh [skill-name ...]
#
# With no arguments, checks every directory under skills/. With one or more
# names, checks only those (e.g. `scripts/validate-skills.sh auto-docs`).
#
# This is the one place generic, cross-skill checks live — individual skills
# should not re-implement frontmatter/portability checks in their own
# scripts/validate-skill.sh; that file should hold only behavior specific to
# that skill (e.g. setup-docs's init.sh idempotency test) and can shell out
# here for the generic phase.
#
# Checks per skill:
#   1. SKILL.md exists.
#   2. Frontmatter `name:` matches the skill's directory name.
#   3. Frontmatter has a non-empty `description:`.
#   4. No Claude-Code-only frontmatter (e.g. disable-model-invocation) —
#      keeps the skill loadable by any harness that adopted the open
#      Agent Skills spec, not just Claude Code.
#   5. No instruction phrased as invoking a specific tool by name
#      (e.g. "the Read tool") — instructions should describe the action.
#   6. `npx skills-ref validate` passes, if npx is available — the spec's
#      own reference validator, authoritative over anything reinvented here.
#   7. A README.md and evals/evals.json are present (repo convention for a
#      finished skill) — reported as a warning, not a hard failure, since a
#      skill may still be under active development.
#   8. If evals/evals.json is present: its skill_name matches the directory
#      name, and it has at least 3 evaluations — hard failures, since a
#      malformed evals file that exists is a real defect, not a
#      still-in-progress skill.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

fail_count=0
warn_count=0

pass () { echo "  PASS: $1"; }
warn () { echo "  WARN: $1"; warn_count=$((warn_count + 1)); }
fail () { echo "  FAIL: $1"; fail_count=$((fail_count + 1)); }

check_skill () {
  local dir="$1"
  local name
  name="$(basename "$dir")"
  echo "--- $name ---"

  local skill_md="$dir/SKILL.md"
  if [ ! -f "$skill_md" ]; then
    fail "SKILL.md exists"
    return
  fi
  pass "SKILL.md exists"

  local name_line
  name_line="$(grep -m1 '^name:' "$skill_md" || true)"
  if [ -z "$name_line" ]; then
    fail "frontmatter has a name: field"
  elif [ "${name_line#name: }" != "$name" ]; then
    fail "frontmatter name ('${name_line#name: }') matches directory name ('$name')"
  else
    pass "frontmatter name matches directory name"
  fi

  local desc_line
  desc_line="$(grep -m1 '^description:' "$skill_md" || true)"
  if [ -z "$desc_line" ] || [ -z "${desc_line#description: }" ]; then
    fail "frontmatter has a non-empty description: field"
  else
    pass "frontmatter has a non-empty description"
  fi

  if grep -qE '^\s*disable-model-invocation\s*:' "$skill_md"; then
    fail "no Claude-Code-only frontmatter fields (found disable-model-invocation)"
  else
    pass "no Claude-Code-only frontmatter fields"
  fi

  if grep -qEi 'the [A-Z][a-zA-Z]* tool' "$skill_md"; then
    fail "no instructions naming a specific tool (e.g. 'the Read tool')"
  else
    pass "no instructions naming a specific tool by name"
  fi

  if command -v npx >/dev/null 2>&1; then
    if npx --yes skills-ref validate "$dir" >/tmp/skills-ref-out.$$ 2>&1; then
      pass "npx skills-ref validate"
    else
      fail "npx skills-ref validate (see below)"
      sed 's/^/    /' /tmp/skills-ref-out.$$
    fi
    rm -f /tmp/skills-ref-out.$$
  else
    warn "npx not available — skipped skills-ref spec validation"
  fi

  if [ -f "$dir/README.md" ]; then
    pass "README.md present"
  else
    warn "no README.md (human-facing orientation doc, expected once the skill is finished)"
  fi

  local evals_json="$dir/evals/evals.json"
  if [ ! -f "$evals_json" ]; then
    warn "no evals/evals.json (scenario evals, expected once the skill is finished)"
  else
    pass "evals/evals.json present"
    if grep -q "\"skill_name\"[[:space:]]*:[[:space:]]*\"$name\"" "$evals_json"; then
      pass "evals.json skill_name matches directory name"
    else
      fail "evals.json skill_name matches directory name ('$name')"
    fi
    local eval_count
    eval_count=$(grep -c '"id"[[:space:]]*:' "$evals_json")
    if [ "$eval_count" -ge 3 ]; then
      pass "evals.json has at least 3 evaluations (found $eval_count)"
    else
      fail "evals.json has at least 3 evaluations (found $eval_count)"
    fi
  fi
}

if [ "$#" -gt 0 ]; then
  for name in "$@"; do
    check_skill "$SKILLS_DIR/$name"
  done
else
  for dir in "$SKILLS_DIR"/*/; do
    [ -d "$dir" ] || continue
    check_skill "${dir%/}"
  done
fi

echo "---"
echo "warnings: $warn_count"
if [ "$fail_count" -eq 0 ]; then
  echo "all skills pass baseline checks"
  exit 0
else
  echo "$fail_count check(s) failed"
  exit 1
fi
