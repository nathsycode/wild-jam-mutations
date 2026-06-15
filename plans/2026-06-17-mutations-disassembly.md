# Day 4 — June 17: More Mutations + Disassembly

> **Prerequisite:** Day 3 complete (2 mutations working)  
> **Goal:** All 4 playable mutations done + disassembly mechanic.

## Tasks

- [ ] **4.1 Snake Head** — Right-click venom projectile (slow + damage)
- [ ] **4.2 Angler Lure** — Attract smaller fish, visible to larger from further
- [ ] **4.3 Disassembly** — Eaten fish scatters mutation parts as fragments
- [ ] **4.4 Fragment collection** — Swim over scattered parts to collect
- [ ] **4.5 Visual** — Mutation parts visible on all fish

## Key GDScript Concepts

- `PackedScene` — instantiate venom projectile
- `move_toward()` — projectile movement
- Fragment spawning (scatter pattern on death)
- `Area2D` for fragment pickup

## Stretch

- Mutation combo effects
