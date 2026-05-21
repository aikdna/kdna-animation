# Animation KDNA Cluster

Apply world-class animation judgment to any motion task. This KDNA cluster teaches what quality means, what to reject, and when to choose restraint — before writing a line of code.

## When to load

Load this cluster when the user asks about:
- Animation, motion design, transitions, easing, timelines
- Making something feel "premium," "smooth," "polished," or "professional" through motion
- Diagnosing why animation looks "cheap," "AI-generated," "chaotic," or "off"
- Building animated UI components, scroll-driven animations, or video explainers
- GSAP, Motion Canvas, CSS animations, or any animation tool
- Performance of animations (jank, frame rate, battery drain)
- Designing a reusable motion system or tokenizing animation

## What it does

This is NOT a skill that teaches API syntax. It is a KDNA judgment cluster — it teaches the agent **what quality means** in animation.

When loaded, the agent will:
- Design an attention path before choosing effects
- Limit simultaneous motion groups to 3 or fewer
- Insert intentional holds between visual beats
- Match easing character to brand tone
- Diagnose "cheap" as a structural problem (density, missing holds, wrong easing), not a taste opinion
- Prioritize removal over addition when fixing animation

## How to load

### For OpenCode / Codex / agents using skills directory:

This SKILL.md itself is the loading trigger. The agent reads this file and loads the KDNA JSON files described below.

Alternatively, if the `kdna-loader` skill is installed, it will auto-discover this cluster and load the right sub-domains based on the user's task.

### Domain files

All KDNA judgment data is in the following files within this folder:

**Always load (minimum):**
- `motion_design_master/KDNA_Core.json` — Foundational axioms: attention, timing, restraint, choreography
- `motion_design_master/KDNA_Patterns.json` — Terminology, banned terms, misunderstandings, self-checks

**Load by task (match to user intent):**
- `gsap_master/` — When the user is working with GSAP, ScrollTrigger, or React animation
- `motion_canvas_master/` — When the user is building programmatic videos or Motion Canvas scenes
- `web_animation_performance/` — When the user reports jank, lag, or performance issues
- `frontend_motion_system/` — When the user is building a reusable motion design system
- `ai_animation_workflow/` — When the user is using an AI agent to generate animation
- `animation_review_master/` — When the user asks to review, diagnose, or critique animation quality

### Task-based loading compositions

| User task | Load these domains |
|-----------|-------------------|
| Web interaction animation | motion_design_master + gsap_master + web_animation_performance + frontend_motion_system |
| Programmatic video explainer | motion_design_master + motion_canvas_master + animation_review_master |
| Agent-generated animation | ai_animation_workflow + motion_design_master + animation_review_master |
| Review and diagnosis | animation_review_master + motion_design_master + web_animation_performance |

### How to apply

After loading the KDNA JSON files:
1. Read the `axioms` — these are the core judgment principles. Apply them to every decision.
2. Check the `banned_terms` and `misunderstandings` — avoid these traps.
3. Use the `stances` as default positions when uncertain.
4. Run the `self_check` questions as a final quality gate before presenting output.
5. When the user gives qualitative feedback ("too busy," "feels cheap"), use the review domain to translate taste words into structural diagnoses before making changes.

## Important

This cluster provides **judgment**, not API recipes. It must be paired with a tool-specific skill (e.g., a GSAP skill or Motion Canvas skill) that teaches API syntax. KDNA tells the agent what is good; a skill tells it how to write the code.
