# AGENTS.md — Godot Wild Jam 94

> **Jam:** [Godot Wild Jam 94](https://itch.io/jam/godot-wild-jam-94)  
> **Duration:** 8 days  
> **Theme:** Mutation  
> **Wildcards (optional):** Disassembly Required (demolish/break things), Checkout (buy stuff), Turtle (include a turtle)  
> **Repo:** `~/games/wild-jam`

---

## Project Overview

A Feeding Frenzy-inspired action game where fish eat smaller fish to gain biomass and pass on genes. The jam theme is **Mutation** — our core mechanic is a direct interpretation: fish develop random body-part mutations that change how they play. Fish can develop random mutations (animal-part fusions: porcupine spikes, giant maw, snake-head venom, etc.). The goal is to collect mutations and become the Apex Predator. NPC fish can also gain mutations by eating other NPCs or the player — and an NPC that eats the player becomes a **Nemesis** (Shadow of Mordor-style persistent rival).

### Core Pillars
1. **Eat to Grow** — Consume smaller fish to gain biomass. Size determines what you can/can't eat.
2. **Mutation Collection** — Random mutations appear on fish. Positive, negative, or mixed effects.
3. **Nemesis System** — NPCs that kill the player evolve into named, persistent rivals with their own mutation sets.
4. **Apex Goal** — Collect enough mutations to dominate the food chain.

---

## Technical Setup

- **Engine:** Godot 4.7 (GL Compatibility renderer)
- **Language:** GDScript (preferred for jam velocity)
- **Resolution:** 1920×1080 base, pixel-art friendly scaling
- **VCS:** Git — commit often, push to remote for backup
- **Node Structure:** TBD as we scaffold, but keep scenes flat and composable

### Project Conventions
- **Scene naming:** `snake_case.tscn`
- **Script naming:** `snake_case.gd`
- **Class naming:** `PascalCase` for class_name, `snake_case` for file
- **Signals:** Always declare at top of script. Use `signal` keyword.
- **Typing:** Use static typing where practical (it helps Godot's editor and catches bugs faster)
- **Groups:** Use Godot groups for categorization (`mutation`, `fish`, `enemy`, `player`, `projectile`)

---

## Development Approach

### Agent's Role
The AI agent is a **co-designer, organizer, and debugger** — not a code factory. The human drives implementation. The agent provides:
- Design sounding-board and idea refinement
- Godot/GDScript lessons and code patterns when asked
- Debugging help and error diagnosis
- Task tracking and prioritization
- Documentation maintenance

### No Vibe Coding
- The human writes the actual game code.
- The agent provides **pseudocode at most** — never exact code lines or entire script files.
- If the human is really struggling, the agent may offer small code snippets or line-by-line guidance, but always with explanation of *why* it works that way.
- The agent explains *why* a pattern works, not just *what* to type.

### Iteration Style
- **Grill-first:** Start each feature with a brief design doc (bullet points in a tracking file or AGENTS.md update).
- **Build:** Implement the minimum viable version.
- **Polish:** Only iterate deeper if time allows at end of jam.

### Pragmatic Philosophy
- **Ugly, fast code over clean code.** This is an 8-day jam. Code doesn't need to survive past Sunday.
- **One-shot over reusability.** Only extract/reuse a pattern when it's used 3+ times. Premature abstraction costs time we don't have.
- **Exports over resources.** Use `@export` groups on scripts instead of dedicated Resource files for parameter config. You can always promote to a Resource later if the species count grows.
- **Inline over indirection.** A direct approach that takes 5 minutes beats an elegant one that takes 20. If the duplication starts to hurt, refactor then.
- **If it works and you can read it, ship it.** Optimize for iteration speed first, readability second, elegance third.

---

## Game Design Notes (Living Document)

### Wildcard Integration Ideas
- **Disassembly Required:** Eating a fish could "disassemble" it — parts fly off, and you can consume specific mutation-parts while the rest scatter. Or: mutations can be shed/removed by taking damage.
- **Checkout:** A mutation shop? Spend biomass to buy/reroll mutations. Or a pre-game "gene checkout" where you pick a starting mutation.
- **Turtle:** Include a turtle NPC. Could be a neutral/defensive creature — shell makes it inedible unless you have Giant Maw. Or a slow-but-tanky playable option.

### Mutations (Draft Catalog)
Mutations are animal-part fusions attached to fish. Each has at least one upside and one downside.

| Mutation | Effect | Trade-off |
|---|---|---|
| **Porcupine Spikes** | Deals damage to anything that touches your rear half | Front is unarmored — vulnerable to head-on attacks |
| **Giant Maw** | Can eat fish up to your own size | After eating, 50% slower for a digestion period |
| **Snake Head** | Spits venom projectiles that slow/damage | Reduced bite damage (mouth is specialized for venom) |
| **Angler Lure** | Attracts smaller fish toward you passively | Emits light — visible to larger predators from further away |
| **Eel Tail** | 2× swim speed burst on cooldown | Burst drains biomass slowly; using it too much shrinks you |

### Nemesis System
- When an NPC fish kills the player, it gets **named** and **persisted**.
- It gains one random mutation from the kill.
- Future encounters: the Nemesis is larger, remembers the player, and hunts aggressively.
- Killing your Nemesis grants bonus biomass + its mutations.
- If a Nemesis kills you again, it grows stronger (mutations stack, size increases).
- Max active Nemeses: TBD (start with 3, tune later).

### Food Chain / Biomass
- Fish size determines diet: you can only eat fish smaller than your mouth size.
- Biomass = health + size. Eating increases both. Taking damage reduces biomass.
- Larger fish move slower (base speed scales inversely with size, mutations can override).

---

## Asset Strategy

- **Self-made:** Quick MS Paint / Aseprite-style pixel art. Embrace "ugly but functional."
- **Free assets:** itch.io free asset packs, Kenney.nl fish pack if available.
- **Sound:** BFXR / jsfxr for sound effects. Free music from jam resources or none (jam is short).
- **Prioritize:** Get placeholder rectangles moving first. Art comes after mechanics work.

---

## Task Tracking

Tasks are tracked here. The agent manages the list; the human marks items done.

### Phase 0: Scaffold & Design (Day 1)
- [x] Create Godot 4.x project in repo root — Godot 4.7, GL Compatibility, named `wild-jam-mutations`
- [x] Finalize mutation catalog (4 initial mutations + 8 stretch, see CONTEXT.md)
- [x] Decide wildcard integration: all 3 (Disassembly Required, Checkout, Turtle)
- [x] Rough paper-sketch of main scene layout
- [x] Set up `.gitignore` (Godot template)
- [x] Create ADRs for key arch decisions (Nemesis→Apex, Biomass=size, Checkout)

### Phase 1: Core Loop (Day 1-2)
- [x] Player fish: basic sprite + mouse-follow movement with steering
- [x] Camera follow (smooth, bounded to 3840×2160)
- [ ] Basic eat mechanic: collision + size comparison → grow
- [ ] NPC fish: simple AI (wander only — flee/chase deferred)

### Phase 2: Mutations (Day 3-4)
- [ ] Mutation data structure (Resource or Dictionary)
- [ ] Visual attachment system (spikes, maw, etc. as child sprites)
- [ ] First 3 mutations implemented (pick from catalog)
- [ ] Mutation pickup on eating mutated fish

### Phase 3: Nemesis (Day 5-6)
- [ ] Nemesis spawn logic (NPC kills player → named + persisted)
- [ ] Nemesis grows stronger on repeat kills
- [ ] Killing Nemesis grants its mutations

### Phase 4: Polish & Ship (Day 7-8)
- [ ] Sound effects (eating, damage, mutation pickup)
- [ ] UI: mutation HUD, biomass meter, nemesis tracker
- [ ] Win condition: become Apex Predator
- [ ] Export to itch.io
- [ ] Jam page write-up + screenshots

---

## Constraints & Reminders

- **8 days only.** Scope aggressively. Cut anything that isn't core.
- **One scene, one mechanic at a time.** Don't build the entire ocean before a fish can swim.
- **Test manually.** No CI. Just run the game and verify.
- **Commit after every working increment.** Even if ugly.
- **Sound and juice come LAST.** Core loop first.
- **If stuck for >30 min on one thing:** Ask the agent. Or cut the feature.
