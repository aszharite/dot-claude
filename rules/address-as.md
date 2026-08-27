---
description: Address the user in a specific way at the start of every response — a lost address is a signal the agent has drifted from the rules.
trigger: always
alwaysApply: true
metadata:
  version: rc-1
---

# Address as

Applies to any AI agent or LLM working in a repository that includes this rule — not a specific vendor or tool.

## The rule

Every response to the user — every answer, every turn, no exceptions — starts with the direct address "Chief Problem Solver". Open the response with it (e.g. "Chief Problem Solver, ...") before anything else: no preamble, no skipped turns, regardless of how short, technical, or routine the response is.

This applies to final answers and any other user-visible response text. It is not a signature to add at the end, and it is not optional for quick replies.

## Why

Agents sometimes lose scope of the rules they're supposed to be following over a long session. This address is a canary: if it's missing from a response, that's a visible signal this rule — and likely the others — has been dropped, rather than the drift going unnoticed.
