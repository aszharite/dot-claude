---
title: "Threat Model: <Feature/System Name>"
description: Assess threats to a specific feature or system.
cadence: living
updated: <date>
review_cadence: <e.g. per release / quarterly>
---

# Threat Model: <Feature/System Name>

## Assets & trust boundaries
What are we protecting, and where does trust change (e.g. client→server, service→service)?

- List the specific assets an attacker would want (credentials, PII, source code, infra access) — "the database" is too vague to reason about threats against.
- Draw the trust boundaries explicitly: every place data crosses from a less-trusted actor to a more-trusted one (browser to API, third-party webhook to internal queue, contractor laptop to VPN).
- Note what's already trusted implicitly (an internal network, a service mesh) — those assumptions are exactly what attackers exploit once one boundary is breached.

*A threat model without named assets just becomes a generic list of threats — anchor every threat below back to something specific here.*

## Threats considered
Use STRIDE or similar. For each: threat, likelihood, impact, mitigation.

| Threat | Likelihood | Impact | Mitigation | Status |
|---|---|---|---|---|

- Walk each trust boundary through STRIDE (spoofing, tampering, repudiation, information disclosure, denial of service, elevation of privilege) rather than brainstorming threats freeform — it catches categories people forget (repudiation, DoS) far more reliably.
- "Mitigation" should name a control that actually exists or is planned, not an aspiration — "input validation" isn't a mitigation until it's implemented somewhere specific.
- "Status" tracks whether the mitigation is shipped, in progress, or accepted as a residual risk — a table full of "planned" rows six months later is a sign this model isn't being revisited.

## Compliance requirements
Any regulatory/contractual requirements this feature must satisfy (GDPR, SOC2, etc.)

- Name the specific obligation (e.g. GDPR Art. 32, a customer contract's data-residency clause), not just the framework name — "SOC2" alone doesn't tell a reader which control applies.
- Link to the `compliance-checklist.md` or `information-security-policy.md` that governs this in detail instead of restating requirements here.
- Flag anything this feature is *not yet* compliant with — a gap is more useful surfaced here, before launch, than after an auditor finds it.

## Access policy
Who/what can access this, and how is that enforced.

- Name both human and non-human access — service accounts and internal callers get forgotten as often as end users.
- State the enforcement mechanism (auth check, network ACL, IAM policy), not just the intended rule — a rule nothing enforces is just a hope.
- Link to the full `access-policy.md` for this system if one exists rather than duplicating its role/permission table here.
