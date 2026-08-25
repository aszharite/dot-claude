---
title: "API / Data Contract: <Service or Endpoint Name>"
description: Define or update a living API or data contract we own.
cadence: living
updated: <date>
---

# API / Data Contract: <Service or Endpoint Name>

*Update this in the same change set as the code it describes.*

## Endpoints / Interfaces
Method, path, request/response shape (or link to OpenAPI/schema file).

- List every endpoint/method a consumer would call, including ones that feel "internal" — if another team or service can reach it, it's part of the contract.
- Prefer linking to a generated OpenAPI/schema file over hand-writing shapes here; hand-written copies drift from the real contract the moment the code changes and this doc doesn't.
- Note auth requirements per endpoint if they differ (e.g. some routes are public, others need a service token) — don't assume a blanket auth section covers every exception.

## Data model
Key entities and their fields/types.

- Cover request and response shapes, not just the underlying database model — a field can be renamed, flattened, or omitted at the API boundary even if the storage layer looks different.
- Mark which fields are optional vs. required, and which are nullable vs. simply absent — callers handle those differently.

## Error handling
Expected error codes/shapes and what triggers them.

- List error codes as a table or set (status code, condition, response body shape) rather than prose — callers need to branch on this programmatically.
- Distinguish client errors (bad input, unauthorized) from server errors (something we should be alerted on) so consumers know which ones are worth retrying.

## Versioning / breaking-change policy

- State how a breaking change gets introduced (a new version path, a header, a deprecation window) and how long an old version stays supported.
- Define what counts as breaking for this contract specifically — adding an optional field is usually safe, removing or renarrowing one usually isn't; say which category applies to common changes so future editors don't have to guess.
