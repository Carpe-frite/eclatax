extends Node2D

var rng = RandomNumberGenerator.new()
 
@onready var round_end_title = get_node("RoundEndTitle")
@onready var victory_label = get_node("VictoryLabel")
@onready var next_round_button = get_node("NextRoundButton")

@onready var elephant_first_bonus = get_node("ElephantBonus/firstBonus")
@onready var elephant_second_bonus = get_node("ElephantBonus/secondBonus")
@onready var elephant_third_bonus = get_node("ElephantBonus/thirdBonus")

var selected_array = []

func three_boni():
	var total_weights = 0
	for x in global.elephant_effects_array:
		total_weights = total_weights + x["weight"]
	while selected_array.size() < 4:
		for x in global.elephant_effects_array:
			var random_value = rng.randi_range(0,total_weights)
			if x["weight"] <= random_value:
				selected_array.append(x)
			else:
				pass

@onready var levelMusic = get_node("LevelMusicPlayer")
@onready var roundEndSound = get_node("RoundEndSound")



func _ready() -> void:
	roundEndSound.play()
	levelMusic.play(global.continue_level_music_at + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency())
	if global.round_number < 5:
		three_boni()
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
		
		var image_first_bonus = load(selected_array[0]["image"])
		elephant_first_bonus.get_child(0).set_texture(image_first_bonus)
		elephant_first_bonus.get_child(1).text = selected_array[0]["name"].capitalize()
		elephant_first_bonus.get_child(2).text = selected_array[0]["desc"]
		
		var image_second_bonus = load(selected_array[1]["image"])
		elephant_second_bonus.get_child(0).set_texture(image_second_bonus)
		elephant_second_bonus.get_child(1).text = selected_array[1]["name"].capitalize()
		elephant_second_bonus.get_child(2).text = selected_array[1]["desc"]
		
		var image_third_bonus = load(selected_array[2]["image"])
		elephant_third_bonus.get_child(0).set_texture(image_third_bonus)
		elephant_third_bonus.get_child(1).text = selected_array[2]["name"].capitalize()
		elephant_third_bonus.get_child(2).text = selected_array[2]["desc"]
		
	else:
		self.get_parent().get_tree().change_scene_to_file("res://endgame.tscn")
	
func _process(delta: float) -> void:
	pass
	
#func get_elephant_bonus():
	#match x:	

func _on_next_round_button_button_up() -> void:
	global.continue_level_music_at = levelMusic.get_playback_position()  + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://world.tscn")


func _on_first_bonus_button_up() -> void:
	match selected_array[0]["effect"]:
		0: #surpobullation
			global.elephant_bubble_count = 2
