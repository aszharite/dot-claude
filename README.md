# dot-claude

A collection of configurations I share between my workstations, and skills I build to help with my day-to-day personal projects.

## Why dot-claude?

The "claude" part is because I was using Claude when this repo started. Since then I've moved to a more tool-agnostic approach, and this is now the home base for my custom configurations, agent skills, and anything else in that space.

## Skills

| Skill                                         | Command              | Version | Description                                                                                                                                                                                                                                                      | What I use it for?                                                                                                                                                                                                                                                                                                                                                                                 |
| --------------------------------------------- | -------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [setup-docs](skills/setup-docs)               | `/setup-docs`        | `rc-1`  | Scaffolds a standard `/docs` structure — product, design, engineering, testing, operations, security, research — with starter templates, and adds a routing table to the project's agent instruction file(s) so humans and agents write docs to the right place. | I work on projects sporadically and lose context on scope, decisions, and open ideas between sessions. Agents have the same problem, worse — they start every session with zero memory. This skill scaffolds a consistent `/docs` structure and templates up front, so both I and any agent working in the repo have a fixed place to check for context instead of reconstructing it from scratch. |
| [auto-docs](skills/auto-docs)                 | `/auto-docs`         | `rc-1`  | Diagnoses documentation drift by comparing recent project changes against what's documented and updates the affected pages — works on any repo with a docs directory or changelog, not just ones scaffolded by `setup-docs`.                                     | Docs from `setup-docs` still go stale the moment I forget to update them after a change. This closes that loop: pick a scope (uncommitted changes, last commit, since the last changelog commit, or my own description) and it syncs the affected pages instead of me noticing weeks later that they're wrong.                                                                                     |
| [setup-workstation](skills/setup-workstation) | `/setup-workstation` | `rc-1`  | Symlinks this repo's omp config, Claude config, agent config, rules, and skills into the native locations Windows or Mac actually read, so a workstation stays in sync with the repo instead of drifting.                                                        | I work from both a Windows and a Mac workstation and don't want to hand-copy config/rules/skills to keep them matching. This makes the repo the single source of truth — real symlinks, so an edit here is live on every workstation immediately, no separate sync step.                                                                                                                           |

## Rules

Agent-agnostic behavioral rules, the `rules/` equivalent of the Skills table above — see [rules/README.md](rules/README.md) for the full frontmatter schema and per-tool installation mapping.

| Rule                                                    | Version | Purpose & context                                                                                                                                                                                                |
| ------------------------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [address-as](rules/address-as.md)                       | `rc-1`  | Address the user in a specific way at the start of every response. Agents sometimes lose scope of the rules over a session — a missing or wrong address is how I notice it's happened.                           |
| [clarify-before-acting](rules/clarify-before-acting.md) | `rc-1`  | Ask about any decision I haven't explicitly settled, and present the full plan before acting. Agents tend to make too many decisions autonomously — validating direction first avoids wasting time backtracking. |

## Versioning

Every skill and rule carries its own `metadata.version` in frontmatter, independent of this repo's own git history:

| Version             | Meaning                                                                           |
| ------------------- | --------------------------------------------------------------------------------- |
| `alpha-N`           | Still being worked on — shape and behavior can change at any time.                |
| `beta-N`            | Feature-complete enough to test, but not yet trusted for regular use.             |
| `rc-N`              | Ready for others to use — take it with a grain of salt, it can still have issues. |
| `X.Y` (major.minor) | A real release — no longer a release candidate.                                   |

Everything in this repo is currently `rc-1`: usable, but new enough that rough edges are expected.
