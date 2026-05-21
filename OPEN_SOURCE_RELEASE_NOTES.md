# Release notes

## v0.1.0 — Initial open-source release (2026-05-21)

Initial open-source cluster including:

- **7 animation cognition domains**: `motion_design_master`, `gsap_master`, `motion_canvas_master`, `web_animation_performance`, `frontend_motion_system`, `ai_animation_workflow`, `animation_review_master`
- **Cluster manifest** with 4 task-based composition rules and conflict resolution policies
- **Full six-file KDNA structure** for every domain (Core, Patterns, Scenarios, Cases, Reasoning, Evolution)
- **MIT license**

### Quality notes

The first 3 domains (`motion_design_master`, `gsap_master`, `motion_canvas_master`) have undergone thorough content review and contain domain-specific axioms, ontology, scenarios, cases, reasoning chains, and evolution layers.

The remaining 4 domains have been written with domain-specific content in their Core, Patterns, Scenarios, Cases, Reasoning, and Evolution files. Edge cases and additional scenarios will be added in future releases based on community use.

### Known limitations

- No formal JSON schema validation beyond the `validate.sh` script
- Domain-level README files are minimal; richer documentation will be added as the cluster grows
- No agent-specific loading mechanism (Claude plugin, Cursor plugin, etc.) — currently loaded as flat files
