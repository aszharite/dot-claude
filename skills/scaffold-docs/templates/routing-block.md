## Project documentation

Full conventions & full template catalog (75 templates across 7 categories): /docs/README.md

| When you're... | Write/update... | Template |
|---|---|---|
| researching market/users before scoping | /docs/research/ | docs/research/templates/spike.template.md |
| defining what to build | /docs/product/prd.md (+ user stories) | docs/product/templates/prd.template.md |
| designing flows/UI | /docs/design/ | docs/design/templates/flow-spec.template.md |
| making an architectural decision | /docs/engineering/adr/NNNN-title.md | docs/engineering/templates/adr.template.md |
| writing/updating an API or data contract | /docs/engineering/api-spec.md | docs/engineering/templates/api-spec.template.md |
| defining how a feature will be tested | /docs/testing/test-plan.md | docs/testing/templates/test-plan.template.md |
| writing deploy steps or on-call procedures | /docs/operations/runbook.md | docs/operations/templates/runbook.template.md |
| assessing threats/compliance for a feature | /docs/security/threat-model.md | docs/security/templates/threat-model.template.md |

Each category has more scenario-specific templates than shown above (e.g. security also has compliance-checklist, incident-response-plan, vulnerability-assessment; engineering also has rfc, tech-design, data-contract) — check `/docs/<category>/templates/` or `/docs/README.md` when the doc you need isn't one of the 8 above.
