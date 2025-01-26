extends Node2D
 
@onready var round_end_title = get_node("GameEndTitle")
@onready var victory_label = get_node("VictoryLabel")

@onready var eclataxSound = get_node("secretEclatax")

func _ready() -> void:
	if global.elephant_won:
		victory_label.text += "l'elephant !"
	else:
		victory_label.text += "l'abeille !"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_kb_x"):
		eclataxSound.play()
		await get_tree().create_timer(2.70).timeout
		self.get_parent().get_tree().change_scene_to_file("res://menu.tscn")
