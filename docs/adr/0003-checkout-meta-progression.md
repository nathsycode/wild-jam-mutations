# ADR-003: Checkout as Permanent Upgrade Meta-Progression

**Status:** Accepted  
**Date:** 2026-06-14  
**Deciders:** Nathaniel (human), Pi (agent)

---

## Context

The "Checkout" wildcard requires a shopping mechanic. Two fundamentally different approaches were possible:

1. **In-run mutation shop** — During gameplay, spend resources to buy/swap mutations at designated locations or via a menu.
2. **Between-run upgrade shop** — After death, spend persistent currency on permanent upgrades that carry into future runs.

The original AGENTS.md sketch leaned toward option 1 ("pre-game gene checkout where you pick a starting mutation"), but this was ambiguous — it could mean either selecting a mutation for the next run or purchasing permanent upgrades.

---

## Decision

**Checkout is a between-run meta-progression screen.** The player spends **Fish Bucks** (persistent currency earned during runs) on permanent upgrades. These upgrades affect all future runs.

Five upgrades defined:

| Upgrade | Effect |
|---|---|
| **Bombastic** | Starts run with higher biomass |
| **Metabolistic** | Loses less biomass when taking damage |
| **Cannibalistic** | Gains more biomass when eating |
| **Ballistic** | Moves faster |
| **Opportunistic** | Gains more biomass from corpses you didn't kill |

Mutations are acquired **only** during gameplay (by eating/disassembling), not purchased in Checkout.

---

## Rationale

- **Clear separation of concerns:** In-run = mutations (temporary, varied, run-defining). Between-run = upgrades (permanent, cumulative, progression-defining). No confusion about what persists.
- **Roguelike loop:** Death → spend earnings → start stronger → get further → earn more → repeat. This is a proven game loop that gives each death meaning.
- **Run length target (5-10 min):** Short runs need quick turnaround. A between-run shop with a handful of upgrades is faster than an in-run menu that interrupts gameplay.
- **Upgrades solve design problems from ADR-002:** Metabolistic softens the biomass death spiral. Ballistic enables escape. Bombastic speeds up early-game. These are natural solutions to the consequences of "biomass = size, no HP."
- **Fish Bucks integration:** Larger/more-mutated fish drop more Fish Bucks, incentivizing risk-taking. The "grind for upgrades" loop rewards skilled play (killing bigger fish = more currency).

---

## Consequences

### Positive
- Each death is a meaningful progression step, not just a failure.
- Players naturally scale into longer runs as they purchase upgrades.
- No in-game UI interruptions — gameplay stays fluid.
- Upgrade names are thematic and memorable (all end in "-istic").

### Negative
- **Early runs are hard:** Fresh start with no upgrades may feel punishing. Mitigation: start with enough Fish Bucks for one cheap upgrade, or make Bombastic very affordable as a "first buy."
- **Upgrade ceiling:** Once all 5 upgrades are maxed, Checkout loses its function. Mitigation: upgrades could have multiple tiers, or new upgrades unlock as milestones are reached.
- **No in-run spending decisions:** Some players enjoy tactical resource management during gameplay. This design removes that entirely.
- **Scope:** Even a simple upgrade screen requires UI work (buttons, Fish Bucks display, purchase confirmation). This is non-trivial in Godot for a 8-day jam.

---

## Alternatives Considered

| Alternative | Why Rejected |
|---|---|
| In-run mutation shop (reef safe zones) | Interrupts gameplay flow; requires map design; conflicts with short run target. |
| Biomass-as-currency during gameplay | Analysis paralysis mid-combat; undermines "biomass = size" (spending size to buy things feels wrong). |
| Pre-run mutation selection (no permanent upgrades) | Less satisfying progression; each run feels same-ish; no "grind to get stronger" loop. |
| Both in-run shop AND between-run upgrades | Too much scope for jam; splits attention between two economies. |
