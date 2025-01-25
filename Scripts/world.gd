extends Node2D

@onready var timer = get_node("RoundTimer")
@onready var time_left_label = get_node("UI/TimeLeftLabel")

#CLASSES
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	time_left_label.text = str(int(timer.get_time_left()))
	
func _on_round_timer_timeout() -> void:
	self.get_parent().get_tree().change_scene_to_file("res://round_end.tscn")
