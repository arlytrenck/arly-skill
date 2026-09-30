# Design repos worth using

Public GitHub repos for getting better website design out of Claude, picked for auditing an existing site. Stars are omitted on purpose: the counts in search results were not verifiable.

| Repo | What it is | Use it for |
|------|------------|------------|
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Design skill with 24 commands (`audit`, `critique`, `polish`, `typeset`, `layout`, `adapt`) and about 61 local detector rules. | The main review lens. Flags gray text on color, default fonts, pure black and gray, nested cards, bounce easing. |
| [rohitg00/awesome-claude-design](https://github.com/rohitg00/awesome-claude-design) | Catalog of DESIGN.md files grouped by aesthetic family, plus remix recipes and an anti-slop checklist. | Picking a direction and writing a DESIGN.md for the site. |
| [VoltAgent/awesome-claude-design](https://github.com/VoltAgent/awesome-claude-design) | Ready-made DESIGN.md files Claude Design expands into a UI scaffold. | Starting points to adapt, not copy. |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | Portable skills with three dials: DESIGN_VARIANCE, MOTION_INTENSITY, VISUAL_DENSITY. | Tuning how bold the redesign gets. Keep motion low for this site. |
| [wilwaldon/Claude-Code-Frontend-Design-Toolkit](https://github.com/wilwaldon/Claude-Code-Frontend-Design-Toolkit) | Index of 70+ skills, MCP servers and CLAUDE.md tricks. | Finding audit tooling: Addy Osmani web-quality skills, Playwright MCP, Chrome DevTools MCP. |
| [tommyjepsen/awesome-ux-skills](https://github.com/tommyjepsen/awesome-ux-skills) | UX framework skills that apply on design questions. | Flow and usability checks (contact form, nav). |
| [szilu/ux-designer-skill](https://github.com/szilu/ux-designer-skill) | UX/UI guidance with WCAG 2.2 AA. | Accessibility pass. |
| [anthropics/claude-code](https://github.com/anthropics/claude-code) `frontend-design` | Official skill, already installed here. | Baseline taste rules. |

Not yet verified by reading them: awesome-ux-skills, ux-designer-skill, VoltAgent. Read before installing.

## Anti-slop checklist (from impeccable and awesome-claude-design)

- No Inter, Roboto or Arial as the only voice.
- No purple gradients, default teal accents, or animated "live" dots.
- No stacked nested cards, left-bar rules on every container, or default three-column feature grids.
- Tint neutrals, avoid pure black and gray.
- No bounce or elastic easing.
- Icons only when committed to, not a generic set.
