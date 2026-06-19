extends CharacterBody2D
class_name Fish

@onready var Map: TileMapLayer = get_node("/root/Main/World")
@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var movement: MovementComponent = $MovementComponent
@onready var biomass: BiomassComponent = $BiomassComponent
@onready var Debug_Text: Label = $DebugText if has_node("DebugText") else null
@onready var combat: CombatResolver = $CombatResolver

var hit_queue : Array[Dictionary] = []
var target_position: Vector2 = Vector2.ZERO

# Anim Stuff
const MINIMUM_SPEED_ANIM := 5.0
const SWIM_ANIM_NAME = "default"


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var movement_delta = movement.update(delta, target_position, global_position)

	global_position += movement_delta

	global_position = Vector2(
		wrapf(global_position.x, 0, Map.world_width), wrapf(global_position.y, 0, Map.world_height)
	)

	apply_sprite_facing(movement_delta, delta)
	_play_anim()

	if Debug_Text:
		var text = "biomass: %s" % [biomass.current_biomass]
		if is_in_group("Players"):
			text += " | player"
		Debug_Text.text = text
	

func apply_sprite_facing(movement_delta: Vector2, delta: float) -> void:
	var facing_right := movement_delta.x > 0.0

	Sprite.flip_h = facing_right

	var visual_angle := atan2(movement_delta.y, abs(movement_delta.x))

	if not facing_right:
		visual_angle *= -1.0

	var turn_amount: float = clamp(movement.turn_rate * delta, 0.0, 1.0)
	Sprite.rotation = lerp_angle(Sprite.rotation, visual_angle, turn_amount)


func _play_anim() -> void:
	if movement.current_speed > MINIMUM_SPEED_ANIM:
		if not Sprite.is_playing():
			Sprite.play(SWIM_ANIM_NAME)

		Sprite.speed_scale = clamp(movement.current_speed / movement.max_speed, 0.35, 1.5)
	else:
		if Sprite.is_playing():
			Sprite.stop()
		Sprite.frame = 0


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.owner == self:
		return
	
	combat.resolve(self, area.owner)
