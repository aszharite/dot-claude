---
title: "Research: <Topic>"
description: Record a technical or product investigation before it feeds a PRD or ADR.
cadence: write-once
author: <name>
date: <date>
---

# Research: <Topic>

## Question
What were we trying to find out?

- State it as a question with a real answer, not a topic — "can we support X within Y constraint?" is answerable; "look into X" isn't.
- Name the decision this was blocking. A spike with no downstream decision is exploration, not research — that's fine, but say so explicitly.
- If the question shifted mid-investigation (common in spikes), record the question you actually ended up answering, not just the one you started with.

## Method
How did we investigate (interviews, competitive review, technical spike, etc.)?

- Say what you actually did — read docs, built a throwaway prototype, ran a load test, talked to a vendor — not just the category of method.
- Note the time-box or scope limit you worked within; a spike's findings are only as trustworthy as the corners it didn't have time to cut.
- Link to any code, branch, or notebook the spike produced, even if it's disposable — someone will want to check your work later.

## Findings
What did you learn — the raw results, before drawing conclusions from them?

- Report what actually happened, including negative or inconclusive results — a spike that ruled something out is still a completed spike.
- Separate what you observed directly from what you're inferring; a reader should be able to tell "the API returned a 429 after 50 req/s" from "so it probably won't scale to our load."
- Include the specific numbers, errors, or examples that back each finding — "it was slow" is not a finding, "p99 latency was 4.2s at 100 concurrent users" is.

## Implications
What should this change about product/engineering decisions? Link to the PRD or ADR this feeds into, if any.

- Answer the question from the top of the doc directly — a reader skimming just this section should get the bottom line without reading the rest.
- Distinguish "this closes the question" from "this narrows it but leaves a follow-up spike" — don't let an inconclusive result read as a settled one.
- This is a write-once record of what was true when you investigated it — if circumstances change later, write a new spike rather than editing this one.
