extends Fish

@onready var AngleTimer: Timer = $AngleTimer

@export var angle_change_time_min = 1.5
@export var angle_change_time_max = 6.0

@export var angle_range_min = -15.0
@export var angle_range_max = 15.0

const RAND_TARGET_DIST: float = 10000.0


func _ready() -> void:
	super._ready()
	randomize_direction()
	AngleTimer.wait_time = randf_range(angle_change_time_min, angle_change_time_max)
	AngleTimer.start()


func _on_angle_timer_timeout() -> void:
	randomize_direction()
	AngleTimer.wait_time = randf_range(angle_change_time_min, angle_change_time_max)


func randomize_direction() -> void:
	var pitch_deg := randf_range(angle_range_min, angle_range_max)
	var facing := 1.0 if randf() > 0.5 else -1.0

	var target_angle = atan2(sin(deg_to_rad(pitch_deg)), facing * cos(deg_to_rad(pitch_deg)))
	target_position = global_position + Vector2.RIGHT.rotated(target_angle) * RAND_TARGET_DIST
