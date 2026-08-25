---
title: "Model Card: <Model Name>"
description: Document a shipped ML model.
cadence: living
version: <version>
owner: <name>
updated: <date>
---

# Model Card: <Model Name>

## Overview
What the model does, and what it's intended to be used for.

- State the task in concrete terms (classifies X into Y categories, predicts a score between 0 and 1 for Z) rather than a marketing-style description.
- Name where this model is actually deployed/called from — a model card disconnected from its production call sites is hard to act on when something goes wrong.

## Training data
What data the model was trained on, its provenance, and known biases or gaps — link to the relevant `dataset-card.md`.

- Link the dataset card(s) rather than re-describing the data here; if training used multiple datasets or a specific slice/filter of one, say which slice — that detail usually doesn't survive in the dataset card alone.
- Note the training data's time window (data collected before date X) — a model trained on stale data has a shelf life, and this is where a reader finds out.

## Performance
Key metrics, evaluated on what benchmark/test set, and how they compare to any prior version.

- Name the exact metric and eval set (not just "accuracy: 94%" — accuracy on what data, held out how?) — a metric without its evaluation context can't be trusted or reproduced.
- Include a comparison to the previous version if one exists; a metric in isolation doesn't tell a reader whether this model is an improvement or a regression on some dimension.
- Report performance broken down by relevant segments if it varies meaningfully across them (e.g. by language, by user cohort) — an aggregate number can hide a segment where the model performs badly.

## Limitations
Known failure modes, out-of-distribution behavior, and cases where the model should not be trusted.

- Be concrete about failure modes observed during evaluation or in production, not hypothetical ones — "may occasionally be wrong" is true of every model and tells a reader nothing.
- Name what happens on inputs outside the training distribution (a language not in the training set, an input type never seen) — does it fail loudly, or silently produce a low-confidence-but-plausible-looking answer?

## Intended use & out-of-scope use
What this model should be used for, and explicit uses it was not designed/validated for.

- List specific out-of-scope uses, especially ones a reasonable engineer might attempt (using a fraud-risk score as the sole basis for an automated decision when it was validated only as one signal among several).
- If there are use cases with elevated stakes (safety, legal, financial, medical) where this model must not be used without additional review, say so explicitly here rather than assuming it's implied by "not intended for."

## Monitoring
How model performance/drift is monitored in production after deployment.

- Name the actual signal monitored (prediction distribution drift, a proxy label's agreement rate, downstream business metric) and where the dashboard/alert lives.
- State the retraining or rollback trigger — what drift or degradation threshold actually causes someone to act, versus just being visible on a dashboard nobody checks.
