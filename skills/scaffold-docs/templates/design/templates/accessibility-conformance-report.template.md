---
title: "Accessibility Conformance Report: <Product/Surface Name>"
description: Produce a formal VPAT/ACR compliance report for procurement or legal.
cadence: write-once
author: <name>
date: <date>
format: VPAT-style
---

# Accessibility Conformance Report: <Product/Surface Name>

*Distinct from `accessibility-audit.md` — this is a formal, criterion-by-criterion conformance record, typically produced for procurement or legal compliance rather than internal dev use.*

## Scope
Product/surface covered, and the accessibility standard evaluated against (WCAG 2.1 AA, Section 508, EN 301 549).

- Name the exact product version/release and surfaces covered — a conformance report tied to no version becomes unverifiable the moment the product changes.
- State the standard *and* conformance level evaluated against explicitly (e.g. WCAG 2.1 Level AA, not just "WCAG") — procurement reviewers will check this against a specific requirement.
- Note anything excluded from scope (third-party embedded content, a legacy subsection) since an unstated exclusion reads as claimed conformance to anyone reviewing the report.

## Conformance summary
Overall level of conformance: Supports, Partially Supports, Does Not Support, Not Applicable.

- Use the standard VPAT conformance levels consistently (Supports, Partially Supports, Does Not Support, Not Applicable) rather than informal language — this report is typically read against a fixed rubric by someone outside the team.
- The summary should be the honest roll-up of the criterion-by-criterion table below, not a separate judgment call — if the two disagree, the table wins and the summary needs updating.

## Criterion-by-criterion results
| Criterion | Conformance level | Remarks |
|---|---|---|

- List every criterion applicable to the stated standard and level, including ones you fully support — a VPAT/ACR is a complete record, not just a list of gaps.
- "Remarks" should explain *how* it's met or where it falls short, not just restate the conformance level — this is what gives a reviewer (often not a designer) enough to trust the rating.

## Known issues
Any Partially Supports / Does Not Support items, with remediation timeline if planned.

- Pull every non-"Supports" item from the table above into this section with a concrete remediation timeline, or a clear statement that none is planned and why.
- Keep this section consistent with the audit/remediation plan in `accessibility-audit.md` if one exists — a conformance report and an internal audit that disagree on the same issue undermines the credibility of both.

## Contact
Who to contact with accessibility feedback or conformance questions.

- Provide a role or team address, not a single named individual, so the report doesn't go stale when that person changes roles.
- If there's a formal accessibility feedback process (a form, an SLA for response), link to it here rather than just a name.
