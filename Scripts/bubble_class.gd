extends Node2D
		
func bubble_action():
	if Input.is_action_just_released("ui_kb_Space"):
		var new_bubble = bubble.new()
		self.add_child(global.bubble_array[global.bubble_id].bubble_instance)
		global.bubble_id += 1
		
func bubbles_go_up(delta):
	for x in global.bubble_array:
		x.bubble_properties["y"] = x.bubble_properties["y"] - global.speed_bubble * delta
		x.bubble_instance.set_global_position(Vector2(x.bubble_properties["x"],x.bubble_properties["y"]))
		if x.bubble_properties["y"] < 100:
			x.bubble_properties["is_alive"] = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	bubble_action()
	bubbles_go_up(delta)
