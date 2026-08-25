---
title: "Experiment Report: <Experiment Name>"
description: Record the outcome of an A/B test or experiment.
cadence: write-once
author: <name>
date: <date>
---

# Experiment Report: <Experiment Name>

## Hypothesis
What did we predict, and why?

- State it as a testable prediction with a direction ("X will increase conversion") not just a topic ("test the new checkout flow").
- Explain the reasoning behind the prediction — prior data, a user-research finding, a competitor pattern — so a reader can judge whether the result confirms or overturns that reasoning.
- Name the metric the hypothesis is actually about before running the test; picking the "winning" metric after seeing results is how experiments get misread.

## Setup
Variants tested, sample size/duration, success metric, and randomization/assignment method.

- Describe each variant concretely enough that someone could reconstruct what users actually saw, not just a label like "variant B."
- State the sample size and duration together with the success metric — an underpowered test that ran two days is a different kind of result than a well-powered one that ran a full business cycle.
- Note the randomization/assignment method (user-level vs. session-level, any exclusions) since it affects whether the comparison is actually apples-to-apples.

## Results
Observed outcome per variant, including statistical significance if measured.

- Report the actual numbers per variant, not just "variant B won" — include the metric values and the size of the effect, not only its direction.
- State significance explicitly (p-value, confidence interval, or "not statistically significant") rather than implying it — a directional difference with no significance check is not the same claim as a significant one.
- Report secondary/guardrail metrics too, even if they're neutral or negative — a report that only shows the metric that moved in the hoped-for direction is cherry-picked.

## Conclusion
Ship, iterate, or abandon — and what decision this feeds into (link the PRD/ADR).

- State the decision plainly (ship, iterate, abandon, rerun) — a results section without an explicit call leaves the next reader to re-derive one, possibly differently than you would have.
- If the result is mixed (metric moved but a guardrail regressed), say what tipped the decision rather than letting the numbers stand without a verdict.

## Caveats
Anything that limits confidence in these results (sample size, novelty effect, external factors during the test window).

- Name anything that happened during the test window that could confound the result (a marketing push, a holiday, an unrelated outage) — an unflagged confound is how a false result gets treated as settled fact.
- Flag novelty effects explicitly if the test window was short — a lift that's really users reacting to *something changing* often fades and shouldn't be read as a permanent effect.
- This is a record of one test run at a specific time — if you rerun it later and get a different answer, that's a new experiment report, not an update to this one.
