# CONTEXT.md — Wild Jam Mutations

> Domain glossary for the Godot Wild Jam 94 game.  
> **Theme:** Mutation  
> **Wildcards:** Disassembly Required, Checkout, Turtle  
> **Engine:** Godot 4.7 (GL Compatibility)  
> **Target run length:** ~5 minutes (fully upgraded), ~10 minutes (fresh start)

---

## Core Entities

### Fish
Any living creature in the ocean. The universal entity — Player, NPC, Nemesis, Apex, and Turtle are all Fish. Every fish has exactly one numeric attribute: **Biomass** (its size).

### Player
The human-controlled fish. Starts each run small. Goal: grow by eating smaller fish and collecting mutations, ultimately defeating the current **Apex Predator**.

### NPC
Non-player fish controlled by AI. Behavior depends on relative size vs the observer:
- **Smaller** → flee
- **Similar** → neutral/wander
- **Larger** → chase and attempt to eat

NPCs interact with each other — the ecosystem is fully simulated, not player-centric.

NPCs are spawned by the **Ecosystem Director** in a tier-relative mix: ~50% smaller than Player, ~30% similar size, ~15% larger, ~5% special (Turtles, etc.).

### Nemesis
An NPC that has killed the Player at least once. When created:
- Receives a **name** — randomly generated from Adjective + Name lists (e.g., "Snapping Terry", "Silent Brutus")
- Gains one **mutation** from the kill
- Becomes aggressive toward the Player on sight
- If it kills the Player again, it grows stronger (stacks mutations, gains biomass)
- Persists across runs until killed

Nemeses are **dynamic** — if a Nemesis grows large enough, it can become the **Apex Predator**. There is always at most one Apex at a time, but multiple active Nemeses.

### Apex Predator
The single largest fish currently alive in the ocean. The game's final boss.
- **Dynamic role:** Not a static encounter. Any fish (NPC, Nemesis, or Player) becomes the Apex by outgrowing all others.
- **Win condition:** The Player must locate and defeat (eat) the current Apex.
- If a Nemesis becomes the Apex, it carries its grudge and accumulated mutations into the role.

### Turtle
A neutral NPC fish. Inedible by default — its shell blocks consumption.
- Wanders passively through the ocean.
- Can carry **mutations** (visible as attachments on its shell).
- Only edible by a fish with the **Giant Maw** mutation.
- Eating a Turtle grants its mutations.

---

## Core Concepts

### Biomass
A fish's size. The single attribute that determines everything:
- **Place in food chain** — can only eat fish with visibly lower biomass.
- **Growth** — eating increases biomass.
- **Shrinkage** — taking damage reduces biomass (and thus place in the food chain).
- There is no separate "health" stat. You are alive until something larger eats you.

### Food Chain (Strict Size Tier)
A fish can only eat another fish that is **visibly smaller** than itself. The rule is visual and absolute — no exceptions except what mutations explicitly override (e.g., Giant Maw allows eating same-size fish during its window).

**Tier progression:** smaller → similar → larger → Apex. The Apex is simply whatever fish currently has the highest biomass in the ocean.

### Mutation
A body-part attachment fused to a fish. Each mutation has at least one upside and one downside.
- Acquired by eating a mutated fish (whole) or by **disassembling** one.
- Visual: each mutation appears as a child sprite/node attached to the fish body.
- **Philosophy:** Quantity over quality — ship as many mutations as possible. The playable build scales down to a curated subset, but the catalog should be deep for variety across runs.
- Initial playable subset (4 mutations):

| Mutation | Effect | Trade-off |
|---|---|---|
| **Porcupine Spikes** | Deals damage to anything touching rear half | Front is unarmored — vulnerable head-on |
| **Giant Maw** | Can eat fish up to own size (not just smaller) | 50% slower during digestion period after eating |
| **Snake Head** | Spits venom projectiles (slow + damage) | Reduced bite damage (mouth is specialized) |
| **Angler Lure** | Passively attracts smaller fish toward you | Emits light — visible to larger predators from further away |

- Paper catalog (post-jam / stretch goals):

| Mutation | Effect | Trade-off |
|---|---|---|
| **Eel Tail** | 2× speed burst on cooldown | Burst slowly drains biomass |
| **Puffer Belly** | Inflate to push away fish, appear larger | Costs biomass to activate |
| **Catfish Whiskers** | Highlights essences/fragments through fog | No combat benefit |
| **Squid Ink** | Leave slowing cloud on taking damage | Doesn't work on much larger fish |
| **Jellyfish Tendrils** | Contact drains biomass from nearby fish | Short range, risky to get close |
| **Swordfish Nose** | Charged forward dash attack | Replaces bite, narrow hitbox |
| **Chameleon Skin** | Semi-transparent when stationary | Breaks on movement/attack |
| **Piranha Teeth** | Bites apply brief damage-over-time | No increase to initial bite damage |

### Disassembly
When a fish is eaten, its mutation parts **scatter** as collectible fragments. The eater can consume these scattered parts to acquire the mutations. This is the "Disassembly Required" wildcard — eating doesn't automatically transfer all mutations; some must be chased down.

### Fish Bucks
The persistent currency earned during runs and spent in Checkout. Drop rates (starting values, tune in playtesting):
- **Small fish** (biomass 1-20): 20% chance of 1 Buck
- **Medium fish** (21-60): 40% chance of 1-2 Bucks
- **Large fish** (61+): 60% chance of 1-3 Bucks
- **Mutation bonus:** Each mutation on the eaten fish adds +10% drop chance and +1 to max drop.

### Checkout
The **meta-progression screen** shown between runs (after death). The Player spends **Fish Bucks** to purchase permanent upgrades:

| Upgrade | Effect |
|---|---|
| **Bombastic** | Starts run with higher biomass |
| **Metabolistic** | Loses less biomass when taking damage |
| **Cannibalistic** | Gains more biomass when eating |
| **Ballistic** | Moves faster |
| **Opportunistic** | Gains more biomass from corpses you didn't kill |

Upgrades persist across runs. Checkout is **meta-progression only** — no shopping during active gameplay.

### Run
A single gameplay session from spawn to death (or victory). Target length: ~5 minutes (fully upgraded), ~10 minutes (fresh start).
- **Fish Bucks** earned persist between runs.
- **Nemeses** persist between runs.
- **Checkout upgrades** persist across all runs.
- **Mutations** do NOT persist — each run starts fresh.

### Result Screen
Shown when a run ends (death or victory). Displays:
- Cause of death (e.g., "You were eaten by Snapping Terry")
- Peak Biomass reached
- Mutations Discovered count
- Fish Bucks Earned
- "Proceed to Checkout?" prompt

### Nemesis Naming
Nemesis names are generated from two word lists: **Adjective + Name** (e.g., "Snapping Terry", "Ravenous Brutus"). Lists are curated for flavor — aggressive/predatory adjectives, fish-themed or punchy names. ~20 adjectives × ~20 names = 400 combinations. The adjective may escalate as the Nemesis grows stronger (e.g., "Snapping" → "Ravenous" → "Apex-Eyed").

## Controls

**Mouse-driven:** Fish swims toward the mouse cursor. Left-click to bite/dash. Right-click for venom projectile (Snake Head mutation). Single-hand play, classic Feeding Frenzy feel.

## Run Lifecycle

### Run Start
Player spawns as a **tiny fish** (minimum biomass) in an already-populated arena. The Ecosystem Director seeds the ocean with a tier-relative mix: lots of smaller fish for food, some similar-size competition, and a few larger threats. Nemeses from previous runs may already be present. The Apex Predator is seeded at a high biomass tier but may not be immediately visible due to fog-of-war and zoom level.

### Run End (Death)
When the Player is eaten, the Result Screen displays. Player proceeds to Checkout to spend Fish Bucks on permanent upgrades.

### Run End (Victory)
When the Player eats the Apex Predator, the run is won. Victory screen displays final stats and earned Fish Bucks.

## Data Persistence

Across sessions (saved to disk):
- **Fish Bucks balance**
- **Checkout upgrade levels**
- **Active Nemeses** (name, mutations, biomass)
- **Nemesis name lists** (adjectives and names)

NOT persisted:
- Player biomass (resets each run)
- Active mutations (resets each run)
- Current ecosystem state (regenerated each run)

---

## Scene Architecture

Three additive scenes loaded together:

1. **Ocean** — Background parallax, visual environment, boundary definition, terrain (rocks, reefs).
2. **Game** — All fish entities, spawning, eating logic, mutation system, ecosystem simulation. The authoritative runtime.
3. **UI** — HUD overlay: biomass meter, mutation display, Nemesis tracker.

## Map & Camera

### Movement Architecture

All fish use a shared **`MovementComponent`** Node (child of each fish scene). The component owns movement math only — direction source stays in the parent.

**MovementComponent responsibilities:**
- Speed ramp (lerp acceleration/deceleration)
- Pitch limiting (clamp vertical angle)
- Smooth steering (lerp toward desired pitch)
- Turn penalty (speed retention on 180° flip)
- Wobble (sinusoidal vertical oscillation overlaid on movement)
- World wrapping (wrapf both axes)
- Sprite facing helper (flip_h + rotation lerp)

**Parent provides:** raw direction vector each frame (mouse for Player, AI for NPC).

**Params:** `@export` groups on the component (no Resource file) — keep it fast and inline per Pragmatic Philosophy.

**Wobble effect:** 2-4px amplitude sine wave on Y position. Adds emergent difficulty — aiming at food requires tiny active compensation. Different species get different wobble profiles. Wobble is movement-only; sprite rotation tracks the clean heading, not the wobble-offset position.

---

### Arena
A fixed-size handmade arena (larger than the screen) with scattered rock formations and reef patches. Rocks block movement and line-of-sight; reefs serve as visual landmarks and potential spawn zones. Primarily open water for free movement.

### Dynamic Zoom
Camera zoom adapts to the Player's biomass:
- **Small fish** → zoomed in tight (world feels huge, limited awareness).
- **Growing fish** → camera pulls back (wider perspective, more threats/opportunities visible).
- **Large/Apex-size** → fully zoomed out (see most of the arena).

### Visibility
Two-layer fog-of-war effect around each fish:
- **Radius circle** — everything within a distance ring is visible (like murky water). Radius scales with biomass.
- **Directional cone** — a brighter, higher-contrast cone in front of the fish. Reveals what you're swimming toward more clearly than what's behind you.

---

## Ecosystem Dynamics

- NPCs eat each other, not just the Player.
- Any fish that eats grows; any fish that takes damage shrinks.
- The food chain is in constant motion — the Apex can shift without player involvement.
- **Ecosystem Director:** A procedural system that spawns fish to maintain a dynamic but balanced population. Spawns appropriate-size fish based on the Player's current biomass tier, ensuring there are always things to eat and things to fear.
- **Spawning:** Smaller fish spawn at arena edges and near reefs. Turtles spawn infrequently and are persistent — eating one is a meaningful event.
- **Arena boundary:** Wrap-around edges — fish exit left → appear right, top ↔ bottom. No dead ends.
