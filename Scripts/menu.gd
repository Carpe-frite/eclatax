extends Node2D

@onready var main_menu_music = get_node("AudioStreamPlayer2D")

func _ready() -> void:
	main_menu_music.play()
	
func _process(delta: float) -> void:
	pass

func _on_start_game_button_down() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://world.tscn")

func _on_how_to_play_button_down() -> void:
	global.continue_music_at = main_menu_music.get_playback_position()
	self.get_parent().get_tree().change_scene_to_file("res://how_to_play.tscn")
