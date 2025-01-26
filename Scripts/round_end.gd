extends Node2D
 
@onready var round_end_title = get_node("RoundEndTitle")
@onready var victory_label = get_node("VictoryLabel")
@onready var next_round_button = get_node("NextRoundButton")

@onready var elephant_first_bonus = get_node("ElephantBonus/firstBonus")

@onready var levelMusic = get_node("LevelMusicPlayer")


func _ready() -> void:
	levelMusic.play(global.continue_level_music_at + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency())
	if global.round_number < 5:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		round_end_title.text = "Fin du round " + str(global.round_number)
		if global.elephant_won == true:
			victory_label.text = "L'éléphant remporte le round !"
		else:
			victory_label.text = "L'abeille remporte le round !"
		
		global.round_number += 1
		global.bubble_array = []
		global.bubble_id = 0
		var elephant_x = 960
		next_round_button.text = "Commencer le round " + str(global.round_number)
	else:
		self.get_parent().get_tree().change_scene_to_file("res://endgame.tscn")
	
func _process(delta: float) -> void:
	pass
	
#func get_elephant_bonus():
	#match x:
	

func _on_next_round_button_button_up() -> void:
	global.continue_level_music_at = levelMusic.get_playback_position()  + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://world.tscn")
