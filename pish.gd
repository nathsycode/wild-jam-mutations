extends CharacterBody2D

# Camera and Positioning
@onready var Map := $"../World"
@onready var Cam: Camera2D = $Camera2D

@export var normal_zoom: float = 3.0 # Starts at 3x zoom. Zooms out as biomass increases
@export var intro_zoom: float = 0.5
@export var intro_hold_time: float = 0.6
@export var intro_zoom_time: float = 2.0

# Sprite and Anims
@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D
const MINIMUM_SPEED_ANIM: float = 5.0


# Movement
@export var max_speed: float = 200.0
@export var acceleration: float = 1.25
@export var turn_rate: float = 8.0
@export var max_vertical_angle: float = 40.0
@export var facing_deadzone_px: float = 32.0

@export var turn_retention: float = 0.35
@export var turn_min_speed: float = 100.0

@onready var Debug_Text: Label = $DebugText

var current_speed: float = 0.0
var current_dir: Vector2 = Vector2.LEFT

var facing_sign: float = -1.0
var previous_facing_sign: float = -1.0
var current_pitch: float = 0.0

func _ready() -> void:
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
	
	tween.tween_property(
		Cam,
		"zoom",
		Vector2(normal_zoom, normal_zoom),
		intro_zoom_time
	)


func _process(delta: float) -> void:
	var target := get_global_mouse_position()
	var to_mouse := target - global_position
	
	var desired_dir := current_dir
	
	if to_mouse.length() > 1.0:
		previous_facing_sign = facing_sign
		if to_mouse.x > facing_deadzone_px:
			facing_sign = 1.0
		elif to_mouse.x < -facing_deadzone_px:
			facing_sign = -1.0
		
		var raw_dir = to_mouse.normalized()
		var max_pitch := deg_to_rad(max_vertical_angle)
		
		var desired_pitch := atan2(raw_dir.y, abs(raw_dir.x))
		
		desired_pitch = clamp(desired_pitch, -max_pitch, max_pitch)
		
		desired_dir = Vector2(facing_sign * cos(desired_pitch), sin (desired_pitch)).normalized()
		
		var turn_amount : float = clamp(turn_rate * delta, 0.0, 1.0)
		current_pitch = lerp_angle(current_pitch, desired_pitch, turn_amount)
		
	current_dir = Vector2(facing_sign * cos(current_pitch), sin(current_pitch)).normalized()

	var turn_angle : float = abs(current_dir.angle_to(desired_dir))
	var turn_ratio := turn_angle / PI
	var speed_mult : float = 1.0 - turn_ratio * 0.5
	
	var target_speed := max_speed * speed_mult

	current_speed = lerp(current_speed, target_speed, acceleration * delta)
	
	# Apply Turn Penalty
	if previous_facing_sign != facing_sign and current_speed > turn_min_speed:
			current_speed = max(current_speed * turn_retention, turn_min_speed)
		
	Debug_Text.text = "current m/s: %s" % roundf(current_speed)

	global_position += current_dir * current_speed * delta
	
	apply_sprite_facing(current_dir, delta)

	global_position.x = wrapf(global_position.x, 0, Map.world_width)
	global_position.y = wrapf(global_position.y, 0, Map.world_height)
	
	if current_speed > MINIMUM_SPEED_ANIM:
		if not Sprite.is_playing():
			Sprite.play("default")
		
		Sprite.speed_scale = clamp(current_speed / max_speed, 0.35, 1.5)
	else:
		if Sprite.is_playing():
			Sprite.stop()
		Sprite.frame = 0


func apply_sprite_facing(dir: Vector2, delta: float) -> void:
	var facing_right := dir.x > 0.0
	
	Sprite.flip_h = facing_right
	
	var visual_angle := atan2(dir.y, abs(dir.x))
	
	if not facing_right:
		visual_angle *= -1.0
	
	var turn_amount : float = clamp(turn_rate * delta, 0.0, 1.0)
	Sprite.rotation = lerp_angle(Sprite.rotation, visual_angle, turn_amount)
