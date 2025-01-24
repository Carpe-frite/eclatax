extends Node2D

@onready var acteur_elephant = get_node("Monde/acteurs/elephant")

var bulle = preload("res://bulle.tscn")

#VARIABLES IMPORTANTES
var elephant_x = 100

func move_elephant():
	if Input.is_action_pressed("ui_kb_MoveElephantRight"):
		elephant_x = elephant_x + 15
		acteur_elephant.set_global_position(Vector2(elephant_x,0))
	if Input.is_action_pressed("ui_kb_MoveElephantLeft"):
		elephant_x = elephant_x - 15
		acteur_elephant.set_global_position(Vector2(elephant_x,0))
		
func bubble_action():
	if Input.is_action_pressed("ui_kb_Space"):
		var bubble_instance = bulle.instantiate()		
		self.add_child(bubble_instance)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	move_elephant()
	bubble_action()
