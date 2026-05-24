# Animation KDNA Cluster

An open-source KDNA (Knowledge DNA) cluster for world-class animation judgment in AI agents.

## What is KDNA?

KDNA is a structured knowledge format that teaches AI agents *what matters* in a domain — before they touch a tool or write a line of code. A skill tells an agent **how to use a tool**. A KDNA domain tells an agent **what quality means, what to reject, when to choose restraint, and what the viewer needs**.

This cluster sits above tool-specific AI skills (like gsap-skills, Motion Canvas skills, etc.). Load it alongside your tool skills to give agents director-level judgment.

## Domains

| Domain | Purpose |
|--------|---------|
| `motion_design_master` | Director-level motion judgment: attention, timing, easing, choreography, emotional intent, and restraint |
| `gsap_master` | GSAP production animation: timelines, ScrollTrigger, React integration, plugin choice, performance tradeoffs |
| `motion_canvas_master` | Programmatic video animation: scenes, signals, layout, camera rhythm, explainers, code maintainability |
| `web_animation_performance` | Performance judgment: smooth, battery-aware, accessible web animation |
| `frontend_motion_system` | How teams turn motion into reusable product design systems with tokens, primitives, and shared language |
| `ai_animation_workflow` | Agent workflows for briefing, generating, reviewing, refactoring, and shipping animation |
| `animation_review_master` | Critique standards for diagnosing cheap, noisy, slow, AI-looking, or incoherent animation |

## Recommended loading

Combine domains by task. Don't load all 7 domains at once — pick the right set for the job.

| Task | Domains to load |
|------|----------------|
| **Web interaction motion** | `motion_design_master` + `gsap_master` + `web_animation_performance` + `frontend_motion_system` |
| **Programmatic video explainer** | `motion_design_master` + `motion_canvas_master` + `animation_review_master` |
| **Agent-generated animation** | `ai_animation_workflow` + `motion_design_master` + `animation_review_master` |
| **Review and diagnosis** | `animation_review_master` + `motion_design_master` + `web_animation_performance` |

## Philosophy

World-class motion is not more movement. It is clearer attention, better timing, stronger hierarchy, smoother execution, and more memorable meaning.

## File standard

Each domain follows the six-file KDNA structure:

- `KDNA_Core.json` — Axioms, ontology, frameworks, stances, and the domain's input/judgment/output structure
- `KDNA_Patterns.json` — Terminology boundaries, banned terms, common misunderstandings, and self-check questions
- `KDNA_Scenarios.json` — Concrete triggers that tell the agent when to apply each scenario and how to orient
- `KDNA_Cases.json` — Before/after judgment examples showing bad patterns transformed into master patterns
- `KDNA_Reasoning.json` — Step-by-step chains explaining *why* a specific motion decision is right or wrong
- `KDNA_Evolution.json` — Capability layers (L1/L2/L3), practice loops, and measurable quality indicators

## Usage

### For AI agent users

Copy the entire `kdna-animation/` folder into your agent's knowledge directory.

**Claude Code / Cursor / OpenCode / Codex:**
```
~/.agent/skills/kdna-animation/
```

Reference the cluster in your agent's instructions:

```
Load the Animation KDNA cluster from ~/.agent/skills/kdna-animation/.
For web animation tasks, load the composition: motion_design_master + gsap_master + web_animation_performance.
```

### As a skill companion

KDNA works best when paired with tool-specific skills. For example:

1. Load `gsap-skills` (GreenSock's official skill) to teach the agent GSAP API usage
2. Load `kdna-animation/gsap_master` to teach the agent *when and why* to use timelines, ScrollTrigger restraint, and production choreography

The skill provides the API; the KDNA provides the judgment.

### Cluster manifest

See `cluster_manifest.json` for domain composition rules, conflict resolution policies, and validation expectations.

When domains conflict, the following rules apply:

1. Accessibility and performance override decorative ambition
2. Attention path overrides effect novelty
3. Domain-specific implementation guidance overrides generic motion taste
4. When uncertain, reduce simultaneous motion and increase clarity

## Open-source use

CC-BY-4.0 licensed. You may publish this as a standalone repo, merge it into a registry, or use it as a reference cluster for building other design/engineering KDNA domains.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. Contributions must include all six KDNA files with valid meta fields and domain-specific content (no template placeholders).

## License

CC-BY-4.0 — see [LICENSE](LICENSE) for details.
