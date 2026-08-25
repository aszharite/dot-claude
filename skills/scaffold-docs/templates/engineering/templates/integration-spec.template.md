---
title: "Integration Spec: <External Service Name>"
description: Define a third-party integration's contract.
cadence: living
owner: <name>
updated: <date>
---

# Integration Spec: <External Service Name>

## Purpose
What does this integration provide, and why this external service specifically?

- State what capability we'd lose or have to build ourselves if this integration didn't exist — that's what justifies depending on a third party instead of building in-house.
- Name why this vendor over alternatives, if that was a real decision (cost, feature fit, existing relationship) — future readers evaluating a switch will want to know what was actually being optimized for.

## Authentication
How we authenticate to the external service (API keys, OAuth, mTLS), and where credentials are stored.

- Name the exact mechanism (API key in a header, OAuth client-credentials flow, mTLS cert) — "we authenticate with an API key" without saying where it lives or how it's rotated leaves out the operationally important part.
- State where credentials are stored (a secrets manager, an env var, a vault path) and who can access or rotate them — this is the section an auditor or incident responder will look for first.

## Data exchanged
What data flows in each direction, and in what format.

- Cover both directions separately: what we send them, and what they send back (or push to us via webhook) — integrations are rarely symmetric.
- Note the format (JSON, XML, CSV, a specific SDK's object shape) and whether any of this data is sensitive (PII, payment data) — that changes what handling and logging rules apply.

## Failure handling
What happens when the external service is slow, down, or returns unexpected data — timeouts, retries, circuit breaking, fallback behavior.

- Specify actual numbers: timeout duration, retry count/backoff strategy, and the condition that trips a circuit breaker — "we retry on failure" doesn't tell an on-call engineer what to expect during an outage.
- State the fallback behavior when the service is unavailable: degrade gracefully, queue for later, or fail the user-facing request outright — and whether that choice is even acceptable for this use case.

## Rate limits & quotas
Known limits imposed by the external service, and how we stay within them.

- Record the actual numbers (requests/sec, daily quota) and where they're documented on the vendor's side, since these change and this doc will go stale if it's not linked to the source.
- Explain the mechanism that keeps us under the limit (client-side throttling, a queue, exponential backoff on 429s) — if there isn't one, that's a gap worth naming rather than leaving implicit.

## Contacts & support
How to reach the vendor when something breaks.

- Include the actual escalation path (support email, a Slack Connect channel, an account rep) and any support-tier/SLA that applies — "check their website" isn't useful during an incident.
- Note internal ownership too: who on our side is the point of contact if this integration breaks, in case the on-call engineer isn't the person who set it up.
