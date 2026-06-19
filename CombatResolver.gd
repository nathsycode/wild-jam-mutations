extends Node
class_name CombatResolver

var hit_queue: Array[Dictionary] = []

func resolve(main_fish: CharacterBody2D, enemy_fish: CharacterBody2D) -> void:
	var enemy_biomass: float = enemy_fish.biomass.current_biomass
	var current_biomass: float = main_fish.biomass.current_biomass
	var biomass_diff: float = current_biomass - enemy_biomass
	
	if biomass_diff < 0 or (biomass_diff == 0 and get_instance_id() < enemy_fish.get_instance_id()):
		return
	
	hit_queue.append(
		{"enemy_fish": enemy_fish, 
		"main_fish": main_fish,
		}
	)
	
func process_queue() -> void:
	for arr in hit_queue:
		
		var enemy_fish: CharacterBody2D = arr.enemy_fish
		var main_fish: CharacterBody2D = arr.main_fish
		var main_biomass: BiomassComponent = main_fish.biomass
		var enemy_biomass: BiomassComponent = enemy_fish.biomass
		var enemy_cur_biomass: float = enemy_biomass.current_biomass
		var main_cur_biomass: float = main_biomass.current_biomass
		var biomass_diff: float = arr.biomass_diff
		var biomass_threshold:float = main_biomass.BIOMASS_THRESHOLD
		
		if biomass_diff >= biomass_threshold: # EAT
			main_biomass.consume_biomass(max(1.0, enemy_cur_biomass * 0.2))
			$CrunchQuick.play()
			main_fish.scale.x = 1.0 + main_cur_biomass / main_biomass.MAX_BIOMASS
			main_fish.scale.y = 1.0 + main_cur_biomass / main_biomass.MAX_BIOMASS
			enemy_fish.queue_free()
		elif biomass_diff < biomass_threshold and biomass_diff > -biomass_threshold: # DAMAGE EACH OTHER
			main_biomass.take_damage(max(2.0, main_cur_biomass * 0.10))
			enemy_biomass.take_damage(max(2.0, enemy_cur_biomass * 0.10))
		else: # BOUNCE OFF
			pass
		
	
	hit_queue.clear()
