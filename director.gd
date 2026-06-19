extends Node

@onready var Map: TileMapLayer = %World
@onready var start_bg: AudioStreamPlayer = %StartBG

const MINNOW_SCENE : PackedScene = preload("res://minnow.tscn")

const MINNOW_START_COUNT: int = 50

func _ready() -> void:
	
	# Spawn Minnows
	var spawn_interval: float = 1.0 / MINNOW_START_COUNT
	print(spawn_interval)
	
	for i in MINNOW_START_COUNT:
		await get_tree().create_timer(spawn_interval).timeout
		spawn_fish()
	
	start_bg.play(0.0)
	

func spawn_fish():
	var minnow = MINNOW_SCENE.instantiate()
	add_child(minnow)
	var world_width : int = Map.world_width
	var world_height : int = Map.world_height
	
	minnow.global_position = Vector2(randi_range(0, world_width), randi_range(0, world_height)) # Spawn Anywhere
	minnow.biomass.current_biomass = round(randf_range(5.0, 10.0) if randf_range(1.0, 10.0) < 8.0 else randf_range(10.0, 20.0))
	
func _process(delta: float) -> void:
	pass
