# Day 7 — June 20: Ecosystem + Apex + Turtle

> **Prerequisite:** Day 6 complete (economy works)  
> **Goal:** Full ecosystem simulation, Apex boss, Turtle NPC.

## Tasks

- [ ] **7.1 Ecosystem Director** — Tier-relative spawning (~50% smaller, 30% similar, etc.)
- [ ] **7.2 Apex tracking** — Largest fish alive = Apex, title transfers dynamically
- [ ] **7.3 Apex behavior** — Aggressive, hunts player, visible on HUD
- [ ] **7.4 Win condition** — Eat the Apex → victory screen
- [ ] **7.5 Turtle NPC** — Neutral wanderer, shell (inedible), mutation carrier

## Key GDScript Concepts

- `Timer` for spawn intervals
- Tracking "largest fish" via array sort or max comparison
- Special AI state for Apex (always aggressive)
- Turtle collision exception (blocks eating unless Giant Maw)
- Dynamic zoom (camera scales with biomass)

## Stretch

- Rocks/reefs terrain obstacles
- Apex visual effect (glow/crown)
