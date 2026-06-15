# Day 6 — June 19: Economy + Checkout

> **Prerequisite:** Day 5 complete (Nemeses work)  
> **Goal:** Fish Bucks, result screen, Checkout shop, full persistence.

## Tasks

- [ ] **6.1 Fish Bucks** — Essence drops (RNG by biomass tier + mutation bonus)
- [ ] **6.2 Result screen** — Death stats display (killer, peak biomass, bucks earned)
- [ ] **6.3 Checkout screen** — UI for spending Fish Bucks on upgrades
- [ ] **6.4 Upgrades** — 5 permanent upgrades (Bombastic, Metabolistic, etc.)
- [ ] **6.5 Persistence** — Save Fish Bucks, upgrades, Nemeses to disk

## Key GDScript Concepts

- Scene switching (`get_tree().change_scene_to_file()`)
- `Control` nodes for UI (Button, Label, VBoxContainer)
- Signal connections for button presses
- Reading/writing JSON for save data
- `@export` upgrade costs for easy tuning

## Stretch

- Upgrade tiers (3 levels each)
- Pretty Checkout background
