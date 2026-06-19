# Wild Jam Mutations 🐟

> **Godot Wild Jam 94** — Theme: **Mutation** | Duration: 8 days

A Feeding Frenzy-inspired action game where fish eat smaller fish to gain biomass and pass on genes. Collect mutations (animal-part fusions), become the Apex Predator, and watch out — NPCs that kill you become persistent Nemesis rivals.

## Requirements

- **Godot 4.7+** (download from [godotengine.org](https://godotengine.org/download/))
- **GL Compatibility renderer** (project is configured for this — no changes needed)
- Windows, Linux, or macOS

## Setup

1. **Clone the repo:**
   ```bash
   git clone https://github.com/nathsycode/wild-jam-mutations.git
   cd wild-jam-mutations
   ```

2. **Open in Godot:**
   - Launch Godot 4.7
   - Click **Import** and select the `project.godot` file
   - Or: `File > Import Project... > Browse > select this folder`

3. **Run:**
   - Press **F5** or click the **Play** button (top-right)
   - The main scene should load automatically

## Controls

| Action | Input |
|---|---|
| Move | Mouse cursor (fish follows) |
| *(more controls TBD)* | |

## Project Structure

```
wild-jam-mutations/
├── assets/          # Sprites, sounds, textures
│   └── sounds/      # SFX and music
├── docs/
│   └── adr/         # Architecture Decision Records
├── plans/           # Daily jam plans & design doc
├── AGENTS.md        # Full game design doc & task tracking
├── CONTEXT.md       # Design context & mutation catalog
├── TASKS.md         # Current sprint tasks
├── main.tscn        # Main game scene
├── fish.tscn        # Base fish scene (player + NPC)
├── pish.tscn        # Player fish scene
├── minnow.tscn      # NPC minnow scene
└── *.gd             # GDScript source files
```

## Tech

- **Engine:** Godot 4.7
- **Renderer:** GL Compatibility (OpenGL 3 / Vulkan fallback)
- **Language:** GDScript
- **Resolution:** 1920×1080 (pixel-art friendly)

## Credits

Built by nathsycode for [Godot Wild Jam 94](https://itch.io/jam/godot-wild-jam-94).
