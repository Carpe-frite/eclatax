extends Node2D

@onready var acteur_elephant = get_node("Monde/acteurs/elephant")

#VARIABLES IMPORTANTES
var elephant_x = 100
var speed = 1000

#CLASSES
@onready var bubble = bubble_class

func move_elephant(delta):
	if Input.is_action_pressed("ui_kb_MoveElephantRight"):
		elephant_x = elephant_x + speed * delta
		acteur_elephant.set_global_position(Vector2(elephant_x,0))
	if Input.is_action_pressed("ui_kb_MoveElephantLeft"):
		elephant_x = elephant_x - speed * delta
		acteur_elephant.set_global_position(Vector2(elephant_x,0))
		
func bubble_action():
	if Input.is_action_just_released("ui_kb_Space"):
		var new_bubble = bubble.new()
		self.add_child(global.bubble_array[global.bubble_id].bubble_instance)
		global.bubble_id += 1
		
func bubbles_go_up():
	for x in global.bubble_array:
		print(x.bubble_properties)
		x.bubble_properties["y"] = x.bubble_properties["y"] + 15
		x.bubble_instance.set_global_position(Vector2(2))

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	move_elephant(delta)
	bubble_action()
	bubbles_go_up()
