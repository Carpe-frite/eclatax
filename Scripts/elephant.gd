extends Node

@onready var acteur_elephant = self
@onready var sprite_elephant = get_node("sprite_elephant")

func _ready() -> void:
	pass # Replace with function body.

func move_elephant(delta):
	if Input.is_action_pressed("ui_kb_MoveElephantRight"):
		if global.elephant_x <= get_viewport().size.x - 200:
			global.elephant_x = global.elephant_x + global.speed * delta
			acteur_elephant.set_global_position(Vector2(global.elephant_x,0))
	if Input.is_action_pressed("ui_kb_MoveElephantLeft"):
		if global.elephant_x >= 0:
			global.elephant_x = global.elephant_x - global.speed * delta
			acteur_elephant.set_global_position(Vector2(global.elephant_x,0))

func _process(delta: float) -> void:
	move_elephant(delta)
