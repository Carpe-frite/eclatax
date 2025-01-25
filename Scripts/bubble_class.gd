extends Node2D

@onready var levelMusic = get_node("../../../LevelMusicPlayer")
		
func bubble_action():
	if Input.is_action_just_released("ui_kb_Space"):
		for i in range(global.elephant_bubble_count):
			var new_bubble = bubble.new()
			self.add_child(global.bubble_array[global.bubble_id].bubble_instance)
			global.bubble_id += 1
			if global.checkIfAcquired(global.bee_powerups, "Compiquation"):
				global.bee_speed *= 1.05
	
		
func bubbles_go_up(delta):
	for x in global.bubble_array:
		x.bubble_properties["y"] = x.bubble_properties["y"] - global.speed_bubble * delta
		x.bubble_instance.set_global_position(Vector2(x.bubble_properties["x"],x.bubble_properties["y"]))
		if x.bubble_properties["y"] < 100 and x.bubble_properties["is_alive"] == true:
			global.destroy_bubble(x)
			global.elephant_won = true
			global.continue_level_music_at = levelMusic.get_playback_position()  + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
			self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
			

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	bubble_action()
	bubbles_go_up(delta)
