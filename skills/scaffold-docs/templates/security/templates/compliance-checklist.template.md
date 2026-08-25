---
title: "Compliance Checklist: <Framework/Requirement Name>"
description: Map a regulatory framework's requirements to actual controls.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. quarterly>
---

# Compliance Checklist: <Framework/Requirement Name>

## Scope
What system/data/process does this checklist cover, and which regulation/framework (GDPR, SOC 2, HIPAA, etc.) does it map to?

- Name the exact framework version/section this maps to (e.g. "SOC 2 CC6.1," "GDPR Art. 32") — "we're SOC 2 compliant" without a mapping is a claim nobody can audit.
- State what's explicitly out of scope — a checklist that silently omits a system in scope for the actual audit is worse than no checklist.
- Note who this checklist is for (internal audit, external auditor, customer due-diligence) — that shapes how much detail the evidence column needs.

## Requirements
| Requirement | Control in place | Evidence/link | Status |
|---|---|---|---|

- "Requirement" should quote or closely paraphrase the actual framework clause, not a summary of what you think it means — summaries drift from the source text over time.
- "Control in place" describes the actual mechanism (a policy, a technical control, a process step), not "we handle this," which tells an auditor nothing.
- "Evidence/link" points to something checkable: a config, a log, a signed policy doc, a ticket. If there's no evidence, the status can't honestly be "met."

## Gaps
Requirements not yet met, with a remediation owner and target date.

- Every unmet requirement from the table above should appear here — a gap that only exists in someone's memory isn't tracked.
- Assign a real owner and date, not "TBD" — an unowned gap is the first thing an auditor or incident will surface.
- If a gap has been accepted as a residual risk rather than scheduled for remediation, say so explicitly and link to the risk-assessment that accepted it.

## Last review
Who reviewed this, when, and what changed since the previous review.

- Record the reviewer by name/role, not just a date — accountability for a stale checklist should be traceable to a person.
- Note what changed since last time (a new requirement, a control removed, an evidence link that rotted) — a review that just re-confirms everything unchanged is a signal the review wasn't rigorous.
