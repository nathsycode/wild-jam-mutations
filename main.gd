extends Node2D

@onready var pish: CharacterBody2D = $Pish
@onready var color_rect: ColorRect = $VisibilityMask/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var center_px : Variant = get_viewport().get_canvas_transform() * pish.global_position
	color_rect.material.set_shader_parameter("center_px", center_px)
