# dot-claude

A collection of configurations I share between my workstations, and skills I build to help with my day-to-day personal projects.

## Why dot-claude?

The "claude" part is because I was using Claude when this repo started. Since then I've moved to a more tool-agnostic approach, and this is now the home base for my custom configurations, agent skills, and anything else in that space.

## Skills

| Skill                           | Command       | Description                                                                                                                                                                                                                                                      | What I use it for?                                                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [setup-docs](skills/setup-docs) | `/setup-docs` | Scaffolds a standard `/docs` structure — product, design, engineering, testing, operations, security, research — with starter templates, and adds a routing table to the project's agent instruction file(s) so humans and agents write docs to the right place. | I work on projects sporadically and lose context on scope, decisions, and open ideas between sessions. Agents have the same problem, worse — they start every session with zero memory. This skill scaffolds a consistent `/docs` structure and templates up front, so both I and any agent working in the repo have a fixed place to check for context instead of reconstructing it from scratch. |
