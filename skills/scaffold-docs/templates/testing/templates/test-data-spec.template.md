---
title: "Test Data Spec: <Feature/Test Suite Name>"
description: Document test data and config to prevent false failures.
cadence: living
owner: <name>
updated: <date>
---

# Test Data Spec: <Feature/Test Suite Name>

## Data required
What test data/fixtures this test suite depends on, and why.

- List the actual entities/records needed (specific user roles, account states, product types) and why each one matters to the tests — "some test users" doesn't tell the next person what to recreate.
- Note any data that must NOT be shared with other test suites (to avoid collisions) versus what's safe to share.

## Environment configuration
Environment variables, feature flags, or service configuration required for tests to run correctly.

- List each flag/variable with its required value, not just its name — "FEATURE_X must be enabled," not "there's a flag for this."
- Note config that differs between local and CI — a suite that only works with one machine's `.env` file isn't reproducible.

## Setup
How test data is created/seeded (fixtures, factories, seed scripts) and torn down.

- Name the actual mechanism (a factory library, a seed script, fixture files) and where it lives, not just that "data gets seeded."
- Say explicitly whether teardown happens automatically after each run or needs manual cleanup — leftover data from a suite that doesn't tear down is a common source of the "works on my machine" mystery.

## Known constraints
Anything that causes false failures if not accounted for (e.g. time-zone-dependent data, rate limits in a shared test environment).

- List every constraint that has actually caused a false failure before, not hypothetical ones — this section earns its keep by preventing the same debugging session twice.
- Flag anything time-based (expiring tokens, date-dependent fixtures) separately from anything shared-resource-based (rate limits, seeded data collisions across parallel runs), since they fail in different ways.
