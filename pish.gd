extends Fish

# Camera and Positioning
@onready var Cam: Camera2D = $Camera2D
@onready var AngleCheck: Label = $AngleCheck
@export var normal_zoom: float = 3.0  # Starts at 3x zoom. Zooms out as biomass increases
@export var intro_zoom: float = 0.5
@export var intro_hold_time: float = 0.6
@export var intro_zoom_time: float = 2.0


func _ready() -> void:
	super._ready()
	global_position = Vector2(Map.world_width / 2.0, Map.world_height / 2.0)

	Cam.zoom = Vector2(intro_zoom, intro_zoom)
	Cam.position_smoothing_enabled = false
	Cam.reset_smoothing()

	await get_tree().process_frame
	Cam.position_smoothing_enabled = true

	await get_tree().create_timer(intro_hold_time).timeout

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(Cam, "zoom", Vector2(normal_zoom, normal_zoom), intro_zoom_time)


func _process(delta: float) -> void:
	target_position = get_global_mouse_position()
	super._process(delta)

	AngleCheck.text = "Angle: %s" % rad_to_deg(movement.current_angle)
