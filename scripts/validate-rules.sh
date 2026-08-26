#!/usr/bin/env bash
# validate-rules.sh — schema checks for every rule file in rules/.
#
# Usage: scripts/validate-rules.sh [rule-file-name ...]
#
# With no arguments, checks every *.md file under rules/ except README.md.
# With one or more names (with or without .md), checks only those.
#
# There's no external validator for this schema (unlike skills, which has
# npx skills-ref against the open Agent Skills spec) — description/trigger/
# globs is a convention this repo invented, documented in rules/README.md.
# This script is the only thing that checks a rule file actually matches it.
#
# Checks per rule file:
#   1. File starts with YAML frontmatter (--- ... ---).
#   2. Frontmatter has a non-empty `description:`.
#   3. Frontmatter has a `trigger:` whose value is one of:
#      always, glob, agent-requested, manual.
#   4. `globs:` is present when trigger is `glob`, absent otherwise
#      (rules/README.md: "Required when trigger: glob, omitted otherwise").

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULES_DIR="$REPO_ROOT/rules"
VALID_TRIGGERS="always glob agent-requested manual"

fail_count=0

pass () { echo "  PASS: $1"; }
fail () { echo "  FAIL: $1"; fail_count=$((fail_count + 1)); }

check_rule () {
  local file="$1"
  local name
  name="$(basename "$file" .md)"
  echo "--- $name ---"

  if [ ! -f "$file" ]; then
    fail "file exists ($file)"
    return
  fi

  if [ "$(sed -n '1p' "$file")" != "---" ]; then
    fail "starts with YAML frontmatter"
    return
  fi
  pass "starts with YAML frontmatter"

  local frontmatter
  frontmatter="$(awk 'NR==1{next} /^---$/{exit} {print}' "$file")"

  local desc_line
  desc_line="$(echo "$frontmatter" | grep -m1 '^description:' || true)"
  if [ -z "$desc_line" ] || [ -z "${desc_line#description: }" ]; then
    fail "frontmatter has a non-empty description:"
  else
    pass "frontmatter has a non-empty description"
  fi

  local trigger_line trigger_value
  trigger_line="$(echo "$frontmatter" | grep -m1 '^trigger:' || true)"
  trigger_value="$(echo "${trigger_line#trigger: }" | xargs || true)"
  if [ -z "$trigger_line" ]; then
    fail "frontmatter has a trigger: field"
  elif ! echo " $VALID_TRIGGERS " | grep -q " $trigger_value "; then
    fail "trigger value is one of: $VALID_TRIGGERS (found '$trigger_value')"
  else
    pass "trigger value is valid ('$trigger_value')"
  fi

  local has_globs
  has_globs="$(echo "$frontmatter" | grep -c '^globs:' || true)"
  if [ "$trigger_value" = "glob" ]; then
    if [ "$has_globs" -ge 1 ]; then
      pass "globs: present (required for trigger: glob)"
    else
      fail "globs: present (required for trigger: glob)"
    fi
  else
    if [ "$has_globs" -eq 0 ]; then
      pass "globs: absent (only used for trigger: glob)"
    else
      fail "globs: absent (only used for trigger: glob, but trigger is '$trigger_value')"
    fi
  fi
}

shopt -s nullglob
if [ "$#" -gt 0 ]; then
  for name in "$@"; do
    check_rule "$RULES_DIR/${name%.md}.md"
  done
else
  for file in "$RULES_DIR"/*.md; do
    [ "$(basename "$file")" = "README.md" ] && continue
    check_rule "$file"
  done
fi

echo "---"
if [ "$fail_count" -eq 0 ]; then
  echo "all rules pass schema checks"
  exit 0
else
  echo "$fail_count check(s) failed"
  exit 1
fi
