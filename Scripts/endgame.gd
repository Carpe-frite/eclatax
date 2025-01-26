extends Node2D
 
@onready var round_end_title = get_node("GameEndTitle")
@onready var victory_label = get_node("VictoryLabel")

func _ready() -> void:
	if global.elephant_won:
		victory_label.text += "l'elephant !"
	else:
		victory_label.text += "l'abeille !"
