## Prerequisites

- **kdna CLI**: Install via `npm i -g @aikdna/kdna-cli`
- **Node.js >= 18**

# Contributing

## Core principles

1. **Keep domains small.** Each domain should cover one judgment area. If a domain exceeds 10 axioms or 6 ontology terms, split it.
2. **Judgment, not API docs.** KDNA encodes what matters, what to reject, and what quality means. Do not copy tool documentation or code recipes.
3. **Testable and reviewable.** Every axiom must include a `why` field that explains the reasoning. Every misunderstanding must include a `key_distinction` that separates the false claim from the truth.
4. **No template placeholders.** All content must be domain-specific. Do not submit files with generic `why` fields, copied ontology, or placeholder scenarios.
5. **Six-file completeness.** Every domain must include `KDNA_Core.json`, `KDNA_Patterns.json`, `KDNA_Scenarios.json`, `KDNA_Cases.json`, `KDNA_Reasoning.json`, and `KDNA_Evolution.json`.

## Adding a new domain

1. Create the domain folder using lowercase snake_case (e.g., `threejs_master/`).
2. Write `KDNA_Core.json` with domain-specific axioms, ontology, frameworks, stances, and a unique `load_condition`.
3. Write `KDNA_Patterns.json` with domain-specific terminology, banned terms, misunderstandings, and self-check questions. Do not copy from other domains unless the content genuinely applies.
4. Write `KDNA_Scenarios.json` with at least 2 concrete, domain-specific scenarios.
5. Write `KDNA_Cases.json` with at least 1 before/after judgment case.
6. Write `KDNA_Reasoning.json` with at least 1 domain-specific reasoning chain.
7. Write `KDNA_Evolution.json` with domain-specific capability layers (L1/L2/L3).
8. Write `README.md` for the domain with a 2-3 sentence description.
9. Run `bash validate.sh` to check structure and meta field compliance.
10. Submit a pull request with a description of what judgment the domain adds and why it belongs as a separate domain.

## File validation

Each KDNA JSON file must include the following meta fields:

```json
{
  "meta": {
    "version": "0.1.0",
    "domain": "domain_name",
    "created": "YYYY-MM-DD",
    "purpose": "One-sentence description of this file's role.",
    "load_condition": "When should an AI agent load this file?"
  }
}
```

Run `bash validate.sh` before submitting to verify structure.

## Quality checklist

Before submitting, verify:

- [ ] Every axiom has a domain-specific `why` field (not a generic placeholder)
- [ ] Ontology terms are specific to the domain (not copied from another domain)
- [ ] Frameworks include actionable steps in domain language
- [ ] Stances are opinionated and testable
- [ ] Scenarios have concrete triggers (not just "user says it looks bad")
- [ ] Cases include both a `bad_pattern` and a `master_pattern`
- [ ] Reasoning chains include a `so_what` actionable takeaway
- [ ] Evolution layers progress from basic to expert in domain-specific terms
- [ ] No duplicate IDs within a file
- [ ] `self_check` array contains only self-check items (no misunderstandings leaked in)
