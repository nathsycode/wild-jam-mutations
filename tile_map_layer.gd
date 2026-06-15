extends TileMapLayer

@export var world_width: int = 3840
@export var world_height: int = 2160
@export var tile_size: int = 16

@export var noise_frequency: float = 0.022
@export var noise_seed: int = 12345

const TILE_DARK := 0
const TILE_MID := 1
const TILE_LIGHT := 2

const TILESET_SOURCE_ID := 0

var noise := FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.seed = noise_seed
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = noise_frequency
	
	fill_tiles()
	
func fill_tiles():
	var cols := int(world_width / tile_size)
	var rows := int(world_height / tile_size)

	# --- DEBUG: sample a few cells ---
	for test_row in [0, 30, 60, 90, 120, 134]:
		var depth := float(test_row) / float(rows - 1)
		var n := noise.get_noise_2d(0, test_row)
		var value := 1.0 - depth + n * 0.18
		var tile := pick_tile_index(0, test_row, depth)
		print("row=%d depth=%.3f noise=%.3f value=%.3f → tile=%d" % [test_row, depth, n, value, tile])
	# --- end debug ---

	for row in range(rows):
		var depth := float(row) / float(rows - 1)
		for col in range(cols):
			var tile_index := pick_tile_index(col, row, depth)
			set_cell(Vector2i(col, row), TILESET_SOURCE_ID, Vector2i(tile_index, 0))
			
func pick_tile_index(col: int, row:int, depth: float) -> int:
	var n := noise.get_noise_2d(col, row) * 0.18
	
	# Force a clear vertical gradient:
	# top = high value, bottom = low value
	var value := 1.0 - depth
	
	# Add gentle organic variation
	value += n
	
	if value < 0.33:
		return TILE_DARK
	elif value < 0.58:
		return TILE_MID
	else:
		return TILE_LIGHT
