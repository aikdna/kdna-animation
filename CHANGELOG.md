# Changelog

## [0.2.0] - 2026-05-21

### Changed
- **BREAKING: All 42 KDNA JSON files migrated to v0.4 spec field names**
  - Axioms: `statement` → `one_sentence` + `full_statement` + `why`
  - Ontology: `name`/`definition` → `id`/`one_sentence`/`essence`/`boundary`/`trigger_signal`
  - Misunderstandings: `claim`/`key_distinction` → `wrong`/`correct`/`key_distinction`/`why`
  - Terminology: flattened array → `{standard_terms, banned_terms}` with `replace_with`
  - Self-check: object array → string array
  - Stances: object array → string array
  - Core structure: `{input,judgment,output}` → `[{from,to,via}]`
  - Reasoning: `conclusion`/`logic` → `one_sentence`/`logic`/`so_what`
  - Cases: `brief`/`bad_pattern`/`master_pattern` → `title`/`context`/`what_happened`/`what_was_learned`/`structural_pattern`
  - Scenarios: `scenarios[]` → `scenes[]` with `sub_scenarios`
  - Evolution: `capability_layers` → `stages` + `evolution_layers` + `measurement`
  - `meta.version` fields set to `"0.4"` with new `spec_version` field
- Added `KDNA_Cluster.json` in v0.4 cluster format
- Updated `validate.sh` to check all v0.4 schema fields
- Backups preserved in `.backup_v0.3/`

## [0.1.1] - 2026-05-21

### Added
- Cases density increased from 1-2 to 5-6 per domain (38 total)
- Reasoning chains increased from 1-2 to 5-6 per domain

## [0.1.0] - 2026-05-21

### Added
- Initial open-source release with 7 animation cognition domains
- `cluster_manifest.json` with task-based composition rules and conflict resolution
- Six-file KDNA structure per domain: Core, Patterns, Scenarios, Cases, Reasoning, Evolution
- `motion_design_master`: Director-level motion judgment axioms and frameworks
- `gsap_master`: GSAP production animation engine judgment
- `motion_canvas_master`: Programmatic video animation judgment
- `web_animation_performance`: Performance judgment for web animation
- `frontend_motion_system`: Motion design system tokenization and primitives
- `ai_animation_workflow`: Agent workflow for AI-assisted animation generation
- `animation_review_master`: Structured critique standards for animation quality
- `validate.sh` script for KDNA file structure verification
- MIT license
- Contributing guidelines with quality checklist
