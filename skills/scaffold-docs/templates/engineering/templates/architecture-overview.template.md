---
title: "Architecture Overview: <System/Service Name>"
description: Describe overall system architecture — the current-state picture.
cadence: living
owner: <name>
updated: <date>
---

# Architecture Overview: <System/Service Name>

## Context
What is this system, and what problem does it solve within the broader product?

- Name the system's role in one or two sentences a new engineer could repeat back — what would break, elsewhere, if this system disappeared?
- State who/what depends on this system and who it depends on, at a high level; the detail belongs in Components.

## Components
What are the major pieces (services, databases, queues, external dependencies), and what does each own?

- List each component with a one-line responsibility — if two components' responsibilities overlap, that's worth flagging rather than smoothing over.
- Include external dependencies (third-party APIs, managed services) alongside things this team owns; a reader assessing risk needs both.
- Avoid going deeper than a service/component boundary here — internal module structure belongs in a tech-design, not an architecture overview.

## Data flow
How does a request/event move through the system end to end? A diagram (linked or embedded) is more useful than prose here.

- Walk at least one real request or event from entry point to final effect (a response returned, a row written, a message published) — an architecture that only lists components without tracing a flow leaves the reader to guess how they connect.
- Call out synchronous vs. asynchronous hops explicitly; that's usually where the interesting failure modes live.

## Trust boundaries
Where does client become server, or service become service? This is where auth, validation, and most real vulnerabilities live — name it explicitly, don't leave it implicit.

- Mark every point where data crosses from a less-trusted context to a more-trusted one (browser to API, service to service, third party to us) — each crossing needs to say what's validated there.
- If two internal services trust each other implicitly (no auth between them), say so explicitly; that's a deliberate design choice a reader should be able to see, not discover.

## Key constraints
Scale, latency, consistency, or compliance requirements that shaped the design.

- Include numbers where they exist (requests/sec, p99 latency budget, data volume) — "needs to be fast" doesn't constrain a design decision the way "p99 under 200ms" does.
- Name compliance or regulatory constraints (data residency, retention limits) even if they seem obvious to the current team; they won't be obvious to whoever inherits this system.

## Related ADRs
Link to the specific decisions (`engineering/adr/NNNN-*.md`) that explain *why* this architecture looks the way it does — this doc describes the current state, ADRs explain how it got there.

- Link the ADRs that most shaped the current shape, not every ADR ever written for this system — this is a map to the *why*, not a full index.
