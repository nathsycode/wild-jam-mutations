# Day Plan — June 14: Mini-Aquarium (Basic Scenery)

> **Goal:** Pish swims in a moody ocean arena with fog-of-war.  
> **Target:** ~2 hours. Ship a playable aquarium by end of session.

---

## Step 1: Arena & Camera (30 min)

### 1a. Resize Main Scene
- Open `main.tscn`
- Set the Node2D play area: attach a `ColorRect` or use camera limits
- World size: **3840×2160** (2×2 screens at 1080p). Wrap-around at edges.
- Add ocean background (see Step 3 for tiles)

### 1b. Camera2D Setup
- Add `Camera2D` as child of Main (or Pish for follow)
- Enable smoothing: `position_smoothing_enabled = true`
- `position_smoothing_speed = 5.0` (adjust for feel)
- Set camera limits to world bounds
- **Future:** Dynamic zoom (scale with biomass) — not needed today

### 1c. Verifying
- Run the scene — Pish sprite visible, camera follows

---

## Step 2: Background Tiles (15 min drawing + 15 min setup)

### Art Plan (Aseprite)
- Canvas: **64×64** or **128×128** tile (matches fish's 32px scale — 2-4× fish size)
- Draw **2-3 tiles**:

| Tile | What to draw | Why |
|---|---|---|
| **water_base** | Subtle blue gradient with slight color variation (darker at edges, lighter center) | The repeating background — shader darkens the edges, so this shows through the vision cone |
| **water_detail** (optional) | Same base but with a few subtle light streaks or caustic hints | Mix with base tile randomly for variety without drawing a huge tileset |
| **bubbles_decor** (optional) | A tile with 2-3 small bubbles in the corner | Scatter sparingly — breaks up the grid feel |

- **Colors:** 3-4 shades of deep ocean blue. Keep it dark — the shader's vision cone will be the main light source. Think "midnight zone" with a flashlight.
- **Keep it abstract:** The fog shader carries the mood. Tiles just need to not be flat #0000FF.

### Godot Setup
- Create a `TileMap` node in the Ocean scene
- Set tile size to 64×64 (or whatever you drew)
- Fill the 3840×2160 arena (60×34 tiles at 64px, 30×17 at 128px)
- Mix `water_base` and `water_detail` randomly
- Place `bubbles_decor` at ~5% density (rare enough to feel special)

### What NOT to draw
- No fish, no rocks (rocks are separate sprites placed in the arena)
- No light rays (shader handles directional light)
- No detailed coral/plants (save for reef zones later)

---

## Step 3: Pish Mouse Movement (45 min)

### GDScript Pattern
Attach script to Pish (`pish.gd`). Key concepts:

1. **Read mouse position** in `_process(delta)`  
   `var target = get_global_mouse_position()`

2. **Steering, not teleporting**  
   - Calculate `desired_direction = (target - position).normalized()`  
   - Compare to `current_direction`: how sharp is the turn?  
   - **Sharp turn → slow down. Straight line → speed up.**

3. **Speed lerp**  
   ```gdscript
   var turn_sharpness = abs(current_direction.angle_to(desired_direction)) / PI
   var speed_multiplier = 1.0 - turn_sharpness * 0.5  # lose 50% speed on U-turn
   var target_speed = max_speed * speed_multiplier
   current_speed = lerp(current_speed, target_speed, acceleration * delta)
   ```

4. **Rotation lerp** — fish rotates smoothly toward the cursor  
   `rotation = lerp_angle(rotation, desired_angle, turn_rate * delta)`

5. **Move** — simple direct movement (no physics needed for swimming)  
   `position += Vector2.RIGHT.rotated(rotation) * current_speed * delta`

### What's a "lerp"?
`lerp(a, b, t)` = linear interpolation. When `t` is small (like `delta * 5`), it smoothly moves from `a` toward `b` each frame. This gives you acceleration/deceleration for free — no state machine needed.

### No collision yet
Don't implement eating or size comparison today. Just movement.

---

## Step 4: Fog-of-War Shader (45 min)

### Setup
1. Add `CanvasLayer` to Main (above game, below UI)
2. Add `ColorRect` as child — full screen, black
3. Attach `ShaderMaterial` with a new shader

### Shader Logic (Fragment Shader)
Two uniforms passed from GDScript each frame:
- `vec2 player_screen_pos` — where Pish is on screen
- `vec2 player_direction` — which way Pish is facing (normalized)
- `float vision_radius` — how far Pish can see (grows with biomass later)
- `float cone_angle` — width of forward cone in radians (e.g., 0.8)

At each pixel:
1. Calculate `distance(pixel, player_screen_pos)`
2. If outside radius → fully black (alpha = 1.0)
3. If inside radius — check if inside forward cone:
   - Calculate angle between pixel-to-player vector and player_direction
   - If inside cone → brighter (alpha = 0.0-0.3, slight reveal)
   - If behind → darker (alpha = 0.5-0.7, dim but visible)
4. Smooth the transitions with a soft edge

### GDScript Side
In `_process()`:
```gdscript
shader_material.set_shader_parameter("player_screen_pos", 
    get_viewport().get_camera_2d().global_position + offset_to_center)
shader_material.set_shader_parameter("player_direction", 
    Vector2.RIGHT.rotated(pish.rotation))
shader_material.set_shader_parameter("vision_radius", 300.0)  # tune this
shader_material.set_shader_parameter("cone_angle", 1.2)       # ~70° cone
```

### Why CanvasLayer?
It renders independently of the game world — the shader stays fixed to the screen while the game scrolls. The shader reads the player's *screen-space* position (converted from world position via camera).

---

## Deliverable Check

- [ ] Arena: 3840×2160 world with blue tiled background
- [ ] Camera: Smooth follow on Pish, bounded to arena
- [ ] Pish: Swims to cursor with steering (slow turns, fast straights)
- [ ] Fog: Full-screen shader — dark beyond radius, bright cone forward
- [ ] Wrap: Pish wraps around arena edges

---

## File Changes Today

| File | Action | Notes |
|---|---|---|
| `main.tscn` | Edit | Add Camera2D, CanvasLayer, background |
| `pish.tscn` | Edit | Adjust for free swimming |
| `pish.gd` | **Create** | Movement + steering script |
| `assets/water_base.png` | **Create** | 64×64 water tile |
| `assets/water_detail.png` | **Create** | 64×64 variant tile |
| `fog_shader.gdshader` | **Create** | Fragment shader for vision cone |
| `ocean_bg.gd` | **Create** | TileMap setup or procedural bg |

---

## GDScript Concepts You'll Touch Today

| Concept | Where | Why |
|---|---|---|
| `_process(delta)` | pish.gd | Runs every frame — for movement |
| `lerp()` / `lerp_angle()` | pish.gd | Smooth acceleration + rotation |
| `get_global_mouse_position()` | pish.gd | Where's the cursor? |
| `ShaderMaterial` | fog shader | Apply custom shader to ColorRect |
| `set_shader_parameter()` | pish.gd or Main | Pass player position to GPU |
| `CanvasLayer` | main.tscn | Render fog above game world |
| `Camera2D` | main.tscn | Follow player, set bounds |
| `TileMap` | Ocean scene | Tiled background |

---

## Stretch (if ahead of pace)

- Animate Pish's sprite — slight wiggle or tail bob based on speed
- Add 2-3 NPC fish (static rectangles) swimming in random directions — no AI, just movement
- Particle effect (bubbles trailing behind Pish)
