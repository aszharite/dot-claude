# Project Documentation

Flat structure, 7 categories, no nesting between them. Each folder is a peer — pick the one that matches what you're doing, write there.

## product/
What to build and why. **Living** — updated every cycle.
Contents: PRD, user stories, roadmap, personas, release notes, OKRs, product vision, one-pagers, go-to-market plans, decision log, PR/FAQ.
Templates & routing: see `routing.md` in this folder.

## design/
How it looks and flows. Iterates with product but has its own artifacts.
Contents: UX flow specs, design system notes, component specs, content style, journey maps, accessibility audits/conformance, review checklists, sitemaps.
Templates & routing: see `routing.md` in this folder.

## engineering/
How it's built. ADRs are write-once/append-only decision records; specs and designs are living.
Contents: architecture overviews, ADRs (`engineering/adr/NNNN-title.md`), RFCs, API specs, data models/dictionaries/contracts, technical designs, migration plans, tech debt, integrations, ML model/dataset cards, runtime postmortems.
Templates & routing: see `routing.md` in this folder.

## testing/
How we know it works. Updated per feature/release — don't let this lag behind engineering.
Contents: test strategy, test plans, bug reports, traceability, test summaries, regression checks, performance plans, test data, release sign-off.
Templates & routing: see `routing.md` in this folder.

## operations/
How it runs in production. Post-launch, operational — different audience (on-call) than the build agent.
Contents: deployment guides, runbooks, monitoring plans, incident postmortems, capacity planning, SLOs, on-call handbook, dependency maps, readiness reviews, disaster recovery, release checklists.
Templates & routing: see `routing.md` in this folder.

## security/
What could go wrong and what's required. Regulatory-driven, periodic review.
Contents: threat models, compliance/policy set (information security, acceptable use, change management, vendor management, data classification/retention, logging/monitoring), risk assessments, incident response plan and postmortems, vulnerability assessments, security reviews.
Templates & routing: see `routing.md` in this folder.

## research/
What we learned before/while deciding. Write-once, archival — don't let living specs get cluttered with this.
Contents: market research, competitive analysis, prior art, user research (interview guides and findings), experiments, technical spikes.
Templates & routing: see `routing.md` in this folder.

Each category's `routing.md` has a "Template | Use when... | Key sections" table plus a fallback to the other 6 categories if nothing in that one fits — start there when you know *what* you're writing but not which file to use.

---

## Conventions

- **Naming**: lowercase-with-hyphens.md. ADRs: `NNNN-short-title.md`, zero-padded, sequential.
- **Frontmatter**: every doc (from a template or written ad-hoc) should carry `title`/`description` plus whatever's relevant of `cadence`/`status`/`owner`/`author`/`updated`/`date` — this is what the (optional) freshness check greps instead of parsing prose. Fill in the placeholders when you instantiate a doc from a template; don't leave `<name>`/`<date>` literal.
- **Freshness**: `product`, `design`, `engineering` (specs), `testing` are living — update in the same change set as the work they describe. `engineering/adr`, `research` are append-only — add new files, don't edit history.
- **Ownership**: each category has a primary "consumer" agent/role (see the routing table in the project's agent instructions file) but any contributor can write to any folder — the split is by content type, not by team boundary.
- **Changelog**: every change to a file under `/docs` — by an agent or a human — gets recorded in `CHANGELOG.md` in this directory, under that day's date heading and the file's own heading, with the commit SHA(s) that made the change, in the same change set as the doc edit. See `CHANGELOG.md` for the exact format, including why the SHA is a follow-up step rather than written up front.
- **When a category doesn't apply**: if a project genuinely has no product surface (e.g. pure infra tooling) or no security surface, it's fine to leave that folder seeded-but-empty rather than force content into it.
