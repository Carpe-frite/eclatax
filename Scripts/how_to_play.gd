extends Node2D

@onready var main_menu_music = get_node("AudioStreamPlayer2D")

@onready var audio_button_hover = get_node("AudioButtonBackSound")

func _ready() -> void:
	var continue_music_at_corrected = global.continue_music_at + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	main_menu_music.volume_db = global.menu_music_volume_attenuation
	main_menu_music.play(continue_music_at_corrected)
	
	audio_button_hover.stream = global.buttonClickSounds[randi() % 3]
	audio_button_hover.play()
	
func _on_button_button_up() -> void:
	audio_button_hover.stream = global.buttonClickSounds[randi() % 3]
	audio_button_hover.play()
	
	global.continue_music_at = main_menu_music.get_playback_position() + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://menu.tscn")


func _on_button_mouse_entered() -> void:
	audio_button_hover.stream = global.buttonHoverSounds[randi() % 4]
	audio_button_hover.play()
