# ADR-002: Biomass as Size — No Separate Health Stat

**Status:** Accepted  
**Date:** 2026-06-14  
**Deciders:** Nathaniel (human), Pi (agent)

---

## Context

The game is about eating and growing in a food-chain ecosystem. Most action games separate "health" (how close to death) from "size/power" (how strong you are). AGENTS.md originally described biomass as "health + size" — a combined stat. During design grilling, we needed to decide whether to keep these concepts fused or split them.

Options considered:
1. **Fused** — Biomass = size = survivability. Getting eaten is the only death.
2. **Split** — Separate HP and size. Damage reduces HP; eating increases size. Death at 0 HP regardless of size.
3. **Hybrid** — Biomass is a spendable currency; size is separate and only grows.

---

## Decision

**Biomass is size, period.** There is no separate health stat. A fish is alive until something larger eats it.

- Eating increases biomass → the fish grows.
- Taking damage decreases biomass → the fish shrinks.
- If a fish shrinks enough, smaller fish that were previously prey become predators.
- Death = being eaten by a larger fish (biomass reduced to the point of consumption).

---

## Rationale

- **Diegetic clarity:** The number the player sees (biomass bar) IS what they are. No disconnect between "I have 100 HP but look tiny" or "I'm huge but one hit from death."
- **Direct feedback:** Every hit visibly shrinks the fish. Every meal visibly grows it. The screen tells the whole story without a HUD abstraction.
- **Ecosystem coherence:** The strict size-tier rule ("can only eat visibly smaller fish") works because biomass IS size. A split system would require reconciling two numbers to determine eatability.
- **Simplicity for jam scope:** One number to track, balance, and display. Fewer edge cases (e.g., "I'm at 1 HP but max size — can a tiny fish eat me?").

---

## Consequences

### Positive
- Visual feedback is immediate and truthful — size on screen matches game state.
- Clean integration with the strict size tier food chain rule.
- Death is always a "bigger fish" moment — thematically perfect.
- Simplifies AI: decisions based purely on relative size comparison.

### Negative
- **No comeback buffer:** Traditional HP lets you survive a few hits at any size. Here, taking damage reduces your ability to fight back, creating potential death spirals.
- **Shrink-then-eaten can feel unfair:** A fish that nips you down a tier can then eat you with no counterplay if you've shrunk below its tier.
- **Tuning sensitivity:** Small differences in damage/growth rates compound quickly. A slight imbalance makes the game snowball (winning OR losing).
- **Boss fights (Apex):** The Apex has no HP bar to deplete — the player must outgrow it to eat it. This makes the final encounter about growth racing rather than combat endurance.

---

## Mitigations

- **Metabolistic upgrade** (Checkout): Reduces biomass loss from damage, softening the death spiral.
- **Giant Maw mutation**: Allows eating same-size fish, giving the player a comeback tool even when matched.
- **Escape mechanics**: The player can flee from larger fish (speed boost from Ballistic upgrade, Eel Tail mutation if added later).
- **Tuning target**: 5-10 minute runs mean death spirals end quickly — players are back in Checkout upgrading rather than suffering prolonged unwinnable states.

---

## Alternatives Considered

| Alternative | Why Rejected |
|---|---|
| Split HP + Size | Adds a second number to track; creates edge cases around eatability when HP and size diverge; breaks the visual truth of "bigger = stronger." |
| Biomass as currency, size separate | Two resources with different behaviors; more UI; contradicts the "eating makes you bigger" fantasy. |
| Damage = death, no shrinkage | Simplifies but removes the dynamic food chain shifting — a core ecosystem feature. |
