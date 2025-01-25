extends Node2D

@onready var timer = get_node("RoundTimer")
@onready var time_left_label = get_node("UI/TimeLeftLabel")


#CLASSES
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	time_left_label.text = str(int(timer.get_time_left()))
	if global.is_bubble_selected == true:
		if Input.is_action_just_released("ui_mouse_RightClick"):
			global.destroy_bubble(global.bubble_array[global.currently_selected_bubble_id])
			global.bubble_array.remove_at(global.currently_selected_bubble_id)
			global.bubble_id -= 1
	
func _on_round_timer_timeout() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
