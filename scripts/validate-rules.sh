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
#   5. `alwaysApply: true` is present when trigger is `always` (the omp
#      "agents" provider compat field setup-workstation's symlink relies
#      on — see rules/README.md "Compat fields"), absent otherwise.
#   6. Frontmatter has `metadata.version` matching `alpha-N`, `beta-N`,
#      `rc-N`, or `MAJOR.MINOR` — nested under `metadata` for the same
#      shape as skills' frontmatter, not because rules have a spec to obey.

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

  local always_apply_line
  always_apply_line="$(echo "$frontmatter" | grep -m1 '^alwaysApply:' || true)"
  if [ "$trigger_value" = "always" ]; then
    if [ "$(echo "${always_apply_line#alwaysApply: }" | xargs || true)" = "true" ]; then
      pass "alwaysApply: true present (required for trigger: always)"
    else
      fail "alwaysApply: true present (required for trigger: always)"
    fi
  else
    if [ -z "$always_apply_line" ]; then
      pass "alwaysApply: absent (only used for trigger: always)"
    else
      fail "alwaysApply: absent (only used for trigger: always, but trigger is '$trigger_value')"
    fi
  fi

  local version_line version_value
  version_line="$(echo "$frontmatter" | grep -m1 '^[[:space:]]\+version:' || true)"
  version_value="$(echo "${version_line#*version: }" | xargs || true)"
  if [ -z "$version_line" ]; then
    fail "frontmatter has a metadata.version field"
  elif ! echo "$version_value" | grep -qE '^(alpha|beta|rc)-[0-9]+$|^[0-9]+\.[0-9]+$'; then
    fail "metadata.version matches alpha-N, beta-N, rc-N, or MAJOR.MINOR (found '$version_value')"
  else
    pass "metadata.version is valid ('$version_value')"
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
