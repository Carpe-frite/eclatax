extends Node2D

@onready var main_menu_music = get_node("AudioStreamPlayer2D")

@onready var audio_button_hover = get_node("AudioBoutonHover")

@onready var eclataxSound = get_node("ECLATAXSound")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	eclataxSound.play()
	
	global.bee_powerups = []
	global.elephant_powerups = []
	
	main_menu_music.volume_db = global.menu_music_volume_attenuation
	if global.continue_music_at != 0.0:
		audio_button_hover.stream = global.buttonClickSounds[randi() % 3]
		audio_button_hover.play()
	await get_tree().create_timer(2.70).timeout
	main_menu_music.play(global.continue_music_at + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency())
	
func _process(delta: float) -> void:
	pass

func _on_start_game_button_down() -> void:
	audio_button_hover.stream = global.buttonClickSounds[randi() % 3]
	audio_button_hover.play()
	
	self.get_parent().get_tree().change_scene_to_file("res://world.tscn")

func _on_how_to_play_button_down() -> void:
	global.continue_music_at = main_menu_music.get_playback_position() + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://how_to_play.tscn")


func _on_how_to_play_mouse_entered() -> void:
	audio_button_hover.stream = global.buttonHoverSounds[randi() % 4]
	audio_button_hover.play()


func _on_start_game_mouse_entered() -> void:
	audio_button_hover.stream = global.buttonHoverSounds[randi() % 4]
	audio_button_hover.play()
