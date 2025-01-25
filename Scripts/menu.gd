extends Node2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _on_start_game_button_down() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://world.tscn")


func _on_how_to_play_button_down() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://how_to_play.tscn")
