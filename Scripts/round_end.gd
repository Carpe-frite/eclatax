extends Node2D

var rng = RandomNumberGenerator.new()
 
@onready var round_end_title = get_node("RoundEndTitle")
@onready var victory_label = get_node("VictoryLabel")
@onready var next_round_button = get_node("NextRoundButton")

@onready var elephant_first_bonus = get_node("ElephantBonus/firstBonus")
@onready var elephant_second_bonus = get_node("ElephantBonus/secondBonus")
@onready var elephant_third_bonus = get_node("ElephantBonus/thirdBonus")

@onready var bee_first_bonus = get_node("BeeBonus/firstBeeBonus")
@onready var bee_second_bonus = get_node("BeeBonus/secondBeeBonus")
@onready var bee_third_bonus = get_node("BeeBonus/thirdBeeBonus")

var selected_array = []
var selected_bee_array = []

func three_boni():
	var total_weights = 0
	for x in global.elephant_effects_array:
		total_weights = total_weights + x["weight"]
	while selected_array.size() < 4:
		var random_value = rng.randi_range(0,total_weights)
		var selected_bonus
		var cumulated_weights = 0
		for x in global.elephant_effects_array:
			if cumulated_weights <= random_value:
				cumulated_weights += x["weight"]
				selected_bonus = x
			else:
				break
		selected_array.append(selected_bonus)
	total_weights = 0
	for y in global.bee_effects_array:
		total_weights = total_weights + y["weight"]
	while selected_bee_array.size() < 4:
		var random_value = rng.randi_range(0,total_weights)
		var selected_bonus
		var cumulated_weights = 0
		for x in global.bee_effects_array:
			if cumulated_weights <= random_value:
				cumulated_weights += x["weight"]
				selected_bonus = x
			else:
				break
		selected_bee_array.append(selected_bonus)

@onready var levelMusic = get_node("LevelMusicPlayer")
@onready var roundEndSound = get_node("RoundEndSound")

func _ready() -> void:
	rng.randomize()
	roundEndSound.play()
	levelMusic.play(global.continue_level_music_at + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency())

	if global.round_number < 5:
		three_boni()
		elephant_first_bonus.grab_focus()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		round_end_title.text = "Fin du round " + str(global.round_number)
		
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
		
		#bee
		
		var image_bee_first_bonus = load(selected_bee_array[0]["image"])
		bee_first_bonus.get_child(0).set_texture(image_bee_first_bonus)
		bee_first_bonus.get_child(1).text = selected_bee_array[0]["name"].capitalize()
		bee_first_bonus.get_child(2).text = selected_bee_array[0]["desc"]
		
		var image_bee_second_bonus = load(selected_bee_array[1]["image"])
		bee_second_bonus.get_child(0).set_texture(image_bee_second_bonus)
		bee_second_bonus.get_child(1).text = selected_bee_array[1]["name"].capitalize()
		bee_second_bonus.get_child(2).text = selected_bee_array[1]["desc"]
		
		var image_bee_third_bonus = load(selected_bee_array[2]["image"])
		bee_third_bonus.get_child(0).set_texture(image_bee_third_bonus)
		bee_third_bonus.get_child(1).text = selected_bee_array[2]["name"].capitalize()
		bee_third_bonus.get_child(2).text = selected_bee_array[2]["desc"]
		
	else:
		victory_label.text = "L'abeille remporte le round !"

func _process(delta: float) -> void:
	pass
	
func _on_next_round_button_button_up() -> void:
	global.continue_level_music_at = levelMusic.get_playback_position()  + AudioServer.get_time_since_last_mix() + AudioServer.get_output_latency()
	self.get_parent().get_tree().change_scene_to_file("res://world.tscn")

func _on_first_bonus_button_up() -> void:
	global.elephant_powerups.append(selected_array[0]["name"])

func _on_first_bee_bonus_button_up() -> void:
	global.bee_powerups.append(selected_bee_array[0]["name"])
	bee_second_bonus.visible = false
	bee_third_bonus.visible = false


func _on_second_bonus_button_up() -> void:
	global.elephant_powerups.append(selected_array[1]["name"])

func _on_third_bonus_button_up() -> void:
	global.elephant_powerups.append(selected_array[2]["name"])

func _on_second_bee_bonus_button_up() -> void:
	global.bee_powerups.append(selected_bee_array[1]["name"])
	bee_first_bonus.visible = false
	bee_third_bonus.visible = false


func _on_third_bee_bonus_button_up() -> void:
	global.bee_powerups.append(selected_bee_array[2]["name"])
	bee_first_bonus.visible = false
	bee_second_bonus.visible = false



func _on_first_bonus_pressed() -> void:
	print("1")
	elephant_second_bonus.visible = false
	elephant_third_bonus.visible = false
	global.bee_powerups.append(selected_bee_array[0]["name"])

func _on_second_bonus_pressed() -> void:
	print("2")
	elephant_first_bonus.visible = false
	elephant_third_bonus.visible = false
	global.bee_powerups.append(selected_bee_array[1]["name"])

func _on_third_bonus_pressed() -> void:
	print("3")
	elephant_second_bonus.visible = false
	elephant_first_bonus.visible = false
	global.bee_powerups.append(selected_bee_array[2]["name"])
 
