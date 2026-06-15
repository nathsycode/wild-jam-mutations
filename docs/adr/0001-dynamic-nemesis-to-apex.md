# ADR-001: Dynamic Nemesis-to-Apex System

**Status:** Accepted  
**Date:** 2026-06-14  
**Deciders:** Nathaniel (human), Pi (agent)

---

## Context

The game features a "Nemesis System" inspired by Shadow of Mordor — NPCs that kill the player become persistent, named rivals. The original AGENTS.md sketched Nemeses as mid-game threats, separate from the Apex Predator (final boss). During design grilling, we considered three relationships between Nemeses and the Apex:

1. **Static separation** — Nemeses are mid-game, Apex is a separate static boss.
2. **Apex consumes Nemeses** — The Apex eats idle Nemeses to grow, creating urgency.
3. **Nemeses can become Apex** — Any Nemesis that grows large enough can assume the Apex role, becoming the dynamic final boss.

---

## Decision

**Nemeses can become the Apex Predator.** If a Nemesis outgrows all other fish in the ocean (by eating NPCs, the Player, or other Nemeses), it takes the Apex title. The Apex is not a pre-placed boss — it's the current largest fish, whoever that is.

The Player wins by defeating the current Apex, regardless of whether it started as a Nemesis or a random NPC.

---

## Rationale

- **Personal stakes:** A Nemesis that killed you twice and then became Apex is a far more compelling final boss than a generic big fish.
- **Emergent storytelling:** The "villain arc" writes itself — the fish that got lucky eating you once grows into the ocean's tyrant.
- **Replayability:** Different runs produce different Apex candidates with different mutation loadouts.
- **Fits the theme:** "Mutation" isn't just player-facing — the ecosystem mutates around you.

---

## Consequences

### Positive
- Every death matters — the fish that killed you might become the final boss.
- No need to design a separate boss AI — the Apex uses the same NPC AI tuned for aggression and max size.
- Natural fit with the "ecosystem simulation" approach (NPCs already fight each other).

### Negative
- **Unpredictable difficulty:** The Apex could be a pushover (small NPC grew fastest) or impossibly hard (Nemesis with 4 stacked mutations).
- **Edge case:** If no Nemesis exists and the largest NPC is passive, the "boss fight" may lack drama. Mitigation: the Apex role itself could trigger aggressive behavior regardless of origin.
- **Scope risk:** Dynamic boss generation + ecosystem simulation is more complex than a static boss encounter.
- **Tuning challenge:** Spawn rates and NPC growth rates must be balanced so an Apex emerges on a satisfying timeline without becoming unbeatable.

---

## Alternatives Considered

| Alternative | Why Rejected |
|---|---|
| Static Apex boss (seeded at game start) | Less replayable; no personal connection to Nemesis system. |
| Apex consumes Nemeses to grow | Adds urgency but keeps Apex static; Nemeses are fodder, not rivals. |
| Multiple simultaneous Apex fish | Dilutes the "one big threat" feeling; harder to signal win condition clearly. |
