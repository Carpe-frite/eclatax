extends Node2D

@onready var main_menu_music = get_node("AudioStreamPlayer2D")

func _ready() -> void:
	var continue_music_at_corrected = global.continue_music_at + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	main_menu_music.play(continue_music_at_corrected)
	
func _on_button_button_up() -> void:
	global.continue_music_at = main_menu_music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://menu.tscn")
