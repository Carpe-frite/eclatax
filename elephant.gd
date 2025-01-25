extends Node

@onready var acteur_elephant = self

func _ready() -> void:
	pass # Replace with function body.

func move_elephant(delta):
	if Input.is_action_pressed("ui_kb_MoveElephantRight"):
		global.elephant_x = global.elephant_x + global.speed * delta
		acteur_elephant.set_global_position(Vector2(global.elephant_x,0))
	if Input.is_action_pressed("ui_kb_MoveElephantLeft"):
		global.elephant_x = global.elephant_x - global.speed * delta
		acteur_elephant.set_global_position(Vector2(global.elephant_x,0))

func _process(delta: float) -> void:
	move_elephant(delta)
