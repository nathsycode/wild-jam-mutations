# TASKS.md — Wild Jam Mutations (Kanban Master)

> **Deadline:** June 21 evening (~7 days + 10 hours remaining)  
> **Columns for Kanri:** Backlog → Today → In Progress → Done  
> **Status:** 🔵 = not started, 🟡 = in progress, 🟢 = done

---

## Day 1 — June 14: Mini-Aquarium 🟢

| # | Task | Est. | Status |
|---|---|---|---|
| 1.1 | Arena: 3840×2160 world, wrap-around edges | 30m | 🟢 |
| 1.2 | Background: Draw 3 water tiles (64×64) in Aseprite, set up TileMap with noise gradient | 30m | 🟢 |
| 1.3 | Camera2D: Smooth follow on Pish, bounded to arena | 15m | 🟢 |
| 1.4 | Pish movement: Mouse-follow with steering (slow turns, speed ramp, turn penalty) | 45m | 🟢 |
| 1.5 | Fog shader: Full-screen radial darkness + ambient visibility | 45m | 🟢 |
| 1.6 | Bubbles: 4 sprite sizes as decorative overlay | 15m | 🟢 |

---

## Day 2 — June 15: Core Loop 🟡 (Minimal)

| # | Task | Est. | Status |
|---|---|---|---|
| 2.1 | Eating: Collision detection (Area2D), size comparison → eat or be eaten | 1h | 🔵 |
| 2.2 | Biomass: Grow on eat, shrink on damage. Single stat — no separate HP. | 30m | 🔵 |
| 2.3 | NPC fish: Spawn 5-10 fish, basic wander AI (random direction changes) | 45m | 🔵 |
| 2.4 | ~~Size-relative behavior (flee/chase)~~ *(deferred — minimal loop)* | — | ~~ |
| 2.5 | ~~HUD (biomass meter)~~ *(deferred — debug text suffices for now)* | — | ~~ |

> **Scope cut:** Size-relative NPC behavior and HUD deferred. NPCs wander only. Biomass shown as debug text.
> **Stretch:** Basic eating animation (sprite scale pulse).

---

## Day 3 — June 16: Mutation System

| # | Task | Est. | Status |
|---|---|---|---|
| 3.1 | Mutation data: `Mutation` Resource (name, texture, effect_type, tradeoff) | 30m | 🔵 |
| 3.2 | Visual attachment: Mutation sprites as child nodes on fish body | 30m | 🔵 |
| 3.3 | Porcupine Spikes: Rear-half contact damage, front vulnerable | 1h | 🔵 |
| 3.4 | Giant Maw: Eat same-size fish, 50% slow during digestion timer | 1h | 🔵 |
| 3.5 | Mutation transfer: Eating a mutated fish grants its mutations | 30m | 🔵 |

**Stretch:** NPCs can spawn with random mutations.

---

## Day 4 — June 17: More Mutations + Disassembly

| # | Task | Est. | Status |
|---|---|---|---|
| 4.1 | Snake Head: Right-click venom projectile (slow + damage), reduced bite | 1h | 🔵 |
| 4.2 | Angler Lure: Attract smaller fish passively, visible to larger from further | 45m | 🔵 |
| 4.3 | Disassembly: Eaten fish scatters mutation parts as fragments | 45m | 🔵 |
| 4.4 | Fragment collection: Swim over scattered parts to collect | 30m | 🔵 |
| 4.5 | Visual: Mutation parts visible on all fish (NPCs show their loadout) | 30m | 🔵 |

**Stretch:** Mutation combination effects (Spikes + Maw = ?)

---

## Day 5 — June 18: Nemesis System

| # | Task | Est. | Status |
|---|---|---|---|
| 5.1 | Nemesis creation: NPC kills player → named, gains mutation, persists | 1h | 🔵 |
| 5.2 | Naming: Adjective + Name from two word lists (~20 each) | 30m | 🔵 |
| 5.3 | Nemesis AI: Aggressive hunting behavior, remembers player | 45m | 🔵 |
| 5.4 | Growth: Repeat kills → stack mutations, gain biomass | 30m | 🔵 |
| 5.5 | Persistence: Save/load Nemeses between runs (JSON file) | 45m | 🔵 |

**Stretch:** Nemesis kill grants bonus Fish Bucks + all its mutations.

---

## Day 6 — June 19: Economy + Checkout

| # | Task | Est. | Status |
|---|---|---|---|
| 6.1 | Fish Bucks: Essence drops (RNG by biomass tier + mutation bonus) | 30m | 🔵 |
| 6.2 | Result screen: Death stats (killer name, peak biomass, mutations, bucks) | 30m | 🔵 |
| 6.3 | Checkout screen: UI for spending Fish Bucks on upgrades | 1h | 🔵 |
| 6.4 | Upgrades: Bombastic, Metabolistic, Cannibalistic, Ballistic, Opportunistic | 1h | 🔵 |
| 6.5 | Full persistence: Save Fish Bucks, upgrades, Nemeses to disk | 30m | 🔵 |

**Stretch:** Upgrade tiers (each upgrade has 3 levels).

---

## Day 7 — June 20: Ecosystem + Apex + Turtle

| # | Task | Est. | Status |
|---|---|---|---|
| 7.1 | Ecosystem Director: Tier-relative spawning (~50% smaller, 30% similar, 15% larger, 5% special) | 1h | 🔵 |
| 7.2 | Apex tracking: Largest fish alive = Apex. Title transfers dynamically. | 30m | 🔵 |
| 7.3 | Apex behavior: Aggressive, hunts player, visible on HUD tracker | 45m | 🔵 |
| 7.4 | Win condition: Eat the Apex → victory screen | 30m | 🔵 |
| 7.5 | Turtle NPC: Neutral wanderer, inedible (shell), mutation carrier, Giant Maw only | 45m | 🔵 |

**Stretch:** Rocks/reefs as terrain obstacles. Dynamic zoom scales with biomass.

---

## Day 8 — June 21 (partial day): Polish + Ship

| # | Task | Est. | Status |
|---|---|---|---|
| 8.1 | Sound: BFXR effects — eat, damage, mutation pickup, Nemesis spawn | 1h | 🔵 |
| 8.2 | Visual juice: Particles on eat, screen shake on damage, mutation glow | 45m | 🔵 |
| 8.3 | Playtest + bug fixes: Full run-through, fix critical issues | 1h | 🔵 |
| 8.4 | Export: Windows/Linux builds, test on clean machine | 30m | 🔵 |
| 8.5 | Jam page: Screenshots, description, upload to itch.io | 30m | 🔵 |

---

## Cut List (if behind schedule)

| Priority cut | What to simplify |
|---|---|
| **First** | Turtle NPC → cut entirely, save for post-jam |
| **Second** | Angler Lure mutation → reduce to 3 playable mutations |
| **Third** | Checkout UI polish → text-based menu instead of pretty screen |
| **Fourth** | Ecosystem Director → simple random spawns instead of tier-relative |
| **Fifth** | Rocks/reefs terrain → open water only |

---

## Dependency Graph

```
Day 1 (Aquarium)
  └─→ Day 2 (Core Loop)
        └─→ Day 3 (Mutations)
              └─→ Day 4 (Disassembly + More Mutations)
                    ├─→ Day 5 (Nemesis)
                    │     └─→ Day 6 (Economy)
                    │           └─→ Day 8 (Polish)
                    └─→ Day 7 (Ecosystem + Apex + Turtle)
                          └─→ Day 8 (Polish)
```

Days 5 and 7 can run partially in parallel if needed (different systems).

---

## Kanri Setup

1. Download Kanri from https://www.kanriapp.com/download/
2. Create a new board: **"Wild Jam 94"**
3. Columns: `Backlog` | `Today` | `In Progress` | `Done`
4. Copy each task from above as a card in Backlog
5. Each morning: move that day's tasks from Backlog → Today
6. During work: Today → In Progress → Done

**Kanri tip:** Use the task codes (1.1, 2.3, etc.) as card titles for quick reference.
