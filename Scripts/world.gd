extends Node2D

@onready var timer = get_node("RoundTimer")
@onready var time_left_label = get_node("UI/TimeLeftLabel")


#CLASSES
func _ready() -> void:
	##Scene and bubbles init
	global.bubble_array = []
	global.speed_bubble = 200
	global.currently_selected_bubble_ids = []
	
	

func _process(delta: float) -> void:
	time_left_label.text = str(int(timer.get_time_left()))
	#if global.is_bubble_selected == true:
	if Input.is_action_just_released("ui_mouse_LeftClick"):
		for x in global.currently_selected_bubble_ids:
			global.destroy_bubble(global.bubble_array[x])
			##Exbullession
			if global.checkIfAcquired(global.elephant_powerups, "Exbullession") and global.probability(global.ExbullesionProb, global.elephant_luck):
				var border_spacing = 50
				global.bee_x = randi_range(border_spacing, 1920-border_spacing)
				global.bee_y = randi_range(border_spacing, 1080-border_spacing)
			
			##Pique-Nique
			if global.checkIfAcquired(global.bee_powerups, "Pique-Nique") and global.probability(global.PiqueNiqueProb, global.bee_luck):
				var j
				var valid_bubbles = []
				for i in range(3):
					valid_bubbles = []
					for k in global.bubble_array:
						if k.bubble_properties["is_alive"]:
							valid_bubbles.append(k)
					print(valid_bubbles)
					if len(valid_bubbles) > 0:
						j = randi_range(0, len(valid_bubbles)-1)
						global.destroy_bubble(valid_bubbles[j])
						

	
func _on_round_timer_timeout() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
