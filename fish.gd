extends CharacterBody2D
class_name Fish

@onready var Map: TileMapLayer = get_node("/root/Main/World")
@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var movement: MovementComponent = $MovementComponent
@onready var biomass: BiomassComponent = $BiomassComponent
@onready var Debug_Text: Label = $DebugText if has_node("DebugText") else null

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
	
	for arr in hit_queue:
		
		var biomass_diff:float = arr.biomass_diff
		var enemy_fish: CharacterBody2D = arr.enemy_fish
		var enemy_biomass: float = arr.enemy_biomass
		var current_biomass: float = arr.current_biomass
		var biomass_threshold:float = biomass.BIOMASS_THRESHOLD
		
		if biomass_diff >= biomass_threshold: # EAT
			biomass.consume_biomass(max(1.0, enemy_biomass * 0.2))
			$CrunchQuick.play()
			var ang = global_position.angle_to_point(get_global_mouse_position()) if is_in_group("Players") else global_position.angle_to_point(enemy_fish.global_position)
			global_position += Vector2(cos(ang), sin(ang)) * 10.0 # just an idea exploring (lurch forward) need to delegate to movement component
			scale.x = 1.0 + current_biomass / biomass.MAX_BIOMASS
			scale.y = 1.0 + current_biomass / biomass.MAX_BIOMASS
			enemy_fish.queue_free()
		elif biomass_diff < biomass_threshold and biomass_diff > -biomass_threshold: # DAMAGE EACH OTHER
			biomass.take_damage(max(2.0, current_biomass * 0.10))
			enemy_fish.biomass.take_damage(max(2.0, enemy_biomass * 0.10))
		else: # GET EATEN
			enemy_biomass += biomass.current_biomass * 0.1
			self.queue_free()
		
	
	hit_queue.clear()

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

	var enemy_fish: CharacterBody2D = area.owner
	var enemy_biomass: float = enemy_fish.biomass.current_biomass
	var current_biomass: float = biomass.current_biomass
	var biomass_diff: float = current_biomass - enemy_biomass
	
	if biomass_diff < 0 or (biomass_diff == 0 and get_instance_id() < enemy_fish.get_instance_id()):
		return
	
	hit_queue.append(
		{"enemy_fish": enemy_fish, 
		"enemy_biomass": enemy_biomass,
		"current_biomass": current_biomass,
		"biomass_diff": biomass_diff
		}
	)
