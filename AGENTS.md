# Animation KDNA Cluster

When the user asks for help with **animation, motion design, transitions, easing, UI animation, video explainers, scroll-driven animation, or diagnosing animation quality**, load the KDNA judgment cluster from:

`~/.kdna/domains/animation/`

or if installed in a project directory:

`./kdna/animation/`

## Minimal loading

Always load:
- `motion_design_master/KDNA_Core.json`
- `motion_design_master/KDNA_Patterns.json`

## Task-based additional loading

Match the user's specific task:
- **GSAP / React animation** → also load `gsap_master/`
- **Motion Canvas / video** → also load `motion_canvas_master/`
- **Performance / jank** → also load `web_animation_performance/`
- **Design system / tokens** → also load `frontend_motion_system/`
- **AI agent generating animation** → also load `ai_animation_workflow/`
- **Review / critique / diagnosis** → also load `animation_review_master/`

## Key principles

1. This is a JUDGMENT cluster, not an API reference. Pair with a tool skill.
2. Always define the attention path before choosing effects.
3. Remove motion before adding more. Most bad animation is over-animated.
4. Max 3 simultaneous motion groups. Limit eager animation.
5. Easing communicates emotion. Match easing to brand tone.
