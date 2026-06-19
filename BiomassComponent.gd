extends Node
class_name BiomassComponent

const MAX_BIOMASS: float = 100.0
const BIOMASS_THRESHOLD: float = 5.0

@export var current_biomass: float = 10.0

var is_alive: bool = true

func take_damage(damage: float) -> float:
	current_biomass -= damage
	
	if current_biomass <= 0.0:
		is_alive = false
	
	return current_biomass

func consume_biomass(biomass: float) -> float:
	current_biomass += clamp(biomass, 0.0, 100.0)
	
	if current_biomass >= 100.0:
		print('you are now the apex')
	
	return current_biomass
