---
title: "Change Management Policy: <System/Organization Name>"
description: Govern how a change reaches production, at the process level.
cadence: living
owner: <name>
updated: <date>
review_cadence: <e.g. annually>
---

# Change Management Policy: <System/Organization Name>

## Scope
What kinds of changes this policy governs (code deploys, infra changes, config changes, access changes).

- Be explicit about which change types are covered vs. exempt — a policy that's silent on infra/config changes gets read as "code deploys only," even if that wasn't the intent.
- Note the boundary with `access-policy.md` for access changes specifically — those often need their own approval flow, not this one.

## Change process
How a change is proposed, reviewed, tested, and approved before reaching production.

- Walk the actual path a change takes step by step (proposed → reviewed → tested → approved → deployed) — a process description that skips testing or review as "implied" is exactly where shortcuts creep in under deadline pressure.
- Say what evidence is required at each step (a passing test suite, a reviewer's sign-off, a rollback plan) — a step with no required artifact isn't really enforced.

## Approval requirements
Who must approve which class of change (e.g. low-risk vs high-risk/production-database changes).

- Define the risk tiers concretely (what makes a change "high-risk" here — production database, customer-facing, security-relevant) so the tier isn't left to the submitter's judgment.
- Name specific approver roles per tier, not "a senior engineer" — vague approver requirements are how high-risk changes get rubber-stamped by whoever's convenient.

## Emergency changes
The expedited path for urgent fixes, and how it's reconciled with normal approval after the fact.

- Define what qualifies as an emergency explicitly — without a bar, "emergency" becomes the default way to skip review for anything urgent.
- Require retroactive review within a stated timeframe — an emergency path with no after-the-fact reconciliation step never gets revisited once the fire is out.

## Communication
How changes are communicated to affected stakeholders before/after they land.

- Distinguish who needs advance notice (customers, on-call, dependent teams) from who just needs after-the-fact notification — treating every change the same either spams people or under-notifies the ones who needed to know.
- Name the channel and timing expectation, not just "communicate" — a requirement with no channel or lead time doesn't happen consistently.
