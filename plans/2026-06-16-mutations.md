# Day 3 — June 16: Mutation System

> **Prerequisite:** Day 2 complete (eating + NPCs work)  
> **Goal:** First 2 mutations implemented end-to-end.

## Tasks

- [ ] **3.1 Mutation data** — `Mutation` Resource (name, texture, effect, tradeoff)
- [ ] **3.2 Visual attachment** — Mutation sprites as child nodes on fish
- [ ] **3.3 Porcupine Spikes** — Rear-half contact damage
- [ ] **3.4 Giant Maw** — Eat same-size, 50% slow during digestion
- [ ] **3.5 Mutation transfer** — Eating mutated fish grants its mutations

## Key GDScript Concepts

- `Resource` — custom data containers for mutation definitions
- `@export var mutation: Mutation` — assign in editor
- Child node management (add/remove mutation sprites)
- `Timer` for digestion cooldown (Giant Maw)
- Signal emissions when mutation added/removed

## Stretch

- NPCs spawn with random mutations
