extends Node2D

@onready var timer = get_node("RoundTimer")
@onready var time_left_label = get_node("UI/TimeLeftLabel")


#CLASSES
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	time_left_label.text = str(int(timer.get_time_left()))
	if global.is_bubble_selected == true:
		if Input.is_action_just_released("ui_mouse_LeftClick"):
			global.destroy_bubble(global.bubble_array[global.currently_selected_bubble_id])
			if global.checkIfAcquired(global.elephant_powerups, "Exbullession"):
				var border_spacing = 50
				global.bee_x = randi_range(border_spacing, 1920-border_spacing)
				global.bee_y = randi_range(border_spacing, 1080-border_spacing)

	
func _on_round_timer_timeout() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
