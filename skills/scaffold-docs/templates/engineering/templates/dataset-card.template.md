---
title: "Dataset Card: <Dataset Name>"
description: Document a dataset used for ML.
cadence: living
version: <version>
owner: <name>
updated: <date>
---

# Dataset Card: <Dataset Name>

## Overview
What this dataset contains, and what it's used for.

- State what one record/row represents, and the dataset's approximate size — those two facts orient every reader before they get to detail.
- Name the primary known use(s) (which models train on this, which analyses rely on it) so a reader can judge whether a proposed new use is a reasonable fit.

## Provenance
Where the data came from, and how it was collected.

- Name the original source system(s) — user activity logs, a third-party purchase, manual labeling, a public dataset — provenance determines what licensing, consent, and quality assumptions are even valid.
- If the dataset is derived from another dataset (filtered, joined, relabeled), say what was done and link back to the source; a derived dataset inherits all of the source's limitations plus its own.

## Composition
Size, key fields/features, class balance or distribution where relevant.

- Report the size in the unit that matters for the intended use (rows, unique entities, hours of audio) — "large" isn't a number anyone can plan around.
- For any label or class used in training, report the distribution/balance — a severely imbalanced dataset changes what evaluation metrics are even meaningful.

## Collection process
Sampling method, time period covered, and any consent/licensing considerations.

- State the sampling method (all traffic in a window, a random sample, an actively curated selection) — a non-random sample can bias anything trained or measured on it in ways that aren't obvious downstream.
- Note the time period the data covers; a dataset collected two years ago may no longer reflect current user behavior, and a reader needs this to judge staleness.
- Record consent and licensing basis explicitly (user ToS coverage, an explicit opt-in, a licensed third-party source) — this is what a legal or compliance reviewer will look for first.

## Known limitations
Biases, gaps, or quality issues a consumer should be aware of before using this dataset.

- Name specific gaps (underrepresented segments, a time period with missing data, a known labeling error rate) rather than a generic "may contain biases" disclaimer.
- If a known limitation was already found to cause a downstream problem (a model trained on this underperformed for some segment), say so — that's the most concrete evidence a future consumer can act on.

## Related models
Models trained on this dataset — link to their `model-card.md`.

- Keep this list current as new models are trained on the dataset; it's what lets someone assess blast radius before making a breaking change to this dataset.
