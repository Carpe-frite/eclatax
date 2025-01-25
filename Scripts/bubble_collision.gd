extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_character_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("AAAAAAAAAA")
	if event.is_action_released("ui_mouse_LeftClick") == true:
		print("AAAAAAAAAA")


func _on_character_body_2d_mouse_entered() -> void:
	print("AAAAAAAAAA")
