extends Node
class_name MovementComponent

@export var max_speed: float = 150.0
@export var wobble_amplitude: float = 0.5
@export var wobble_frequency: float = 5.0

@export var acceleration: float = 1.25
@export var turn_rate: float = 8.0
@export var facing_deadzone_px: float = 32.0

@export var turn_retention: float = 0.35
@export var turn_min_speed: float = 100.0

@export var max_vertical_angle: float = 40  #degrees

# State Vars
var current_speed: float = 50.0
var current_angle: float = 0.0
var wobble_time: float = 0.0
var prev_facing_sign: int = 1

func update(delta: float, target_position: Vector2, current_position: Vector2) -> Vector2:
	var to_target = target_position - current_position

	var new_facing_sign = prev_facing_sign

	if to_target.x > facing_deadzone_px:
		new_facing_sign = 1
	elif to_target.x < -facing_deadzone_px:
		new_facing_sign = -1

	var facing_ang: float = 0.0 if new_facing_sign > 0 else PI

	if new_facing_sign != prev_facing_sign:
		if current_speed > turn_min_speed:
			current_speed = max(current_speed * turn_retention, turn_min_speed)

	prev_facing_sign = new_facing_sign

	var ang = current_position.angle_to_point(target_position)
	var max_pitch := deg_to_rad(max_vertical_angle)

	var pitch := wrapf(ang - facing_ang, -PI, PI)
	pitch = clamp(pitch, -max_pitch, max_pitch)

	var target_angle := facing_ang + pitch

	current_angle = lerp_angle(current_angle, target_angle, turn_rate * delta)
	var raw_dir := Vector2(cos(current_angle), sin(current_angle))

	var turn_sharpness := absf(angle_difference(current_angle, target_angle))
	var speed_mult := 1.0 - (turn_sharpness / PI) * 0.9
	var target_speed := max_speed * speed_mult

	current_speed = lerp(current_speed, target_speed, acceleration * delta)

	var movement := raw_dir * current_speed * delta

	wobble_time += delta
	movement.y += sin(wobble_time * wobble_frequency) * wobble_amplitude

	return movement
