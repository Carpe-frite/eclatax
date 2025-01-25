extends Node

var round_number = 1 ##The current round
var elephant_won

var elephant_rounds_won = 0
var bee_rounds_won = 0

var continue_music_at = 0
var continue_level_music_at = 0

var buttonHoverSounds: Array[AudioStream] = [
	preload("res://Assets/Sound/passage souris/Souris_Bouton_1.wav"),
	preload("res://Assets/Sound/passage souris/Souris_Bouton_2.wav"),
	preload("res://Assets/Sound/passage souris/Souris_Bouton_3.wav"),
	preload("res://Assets/Sound/passage souris/Souris_Bouton_4.wav")
]

var buttonClickSounds: Array[AudioStream] = [
	preload("res://Assets/Sound/clic souris/Souris_Clic_1.wav"),
	preload("res://Assets/Sound/clic souris/Souris_Clic_2.wav"),
	preload("res://Assets/Sound/clic souris/Souris_Clic_3.wav")
]

var bubblePopSounds: Array[AudioStream] = [
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_1.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_2.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_3.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_4.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_5.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_6.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_7.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_8.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_9.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_10.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_11.wav"),
	preload("res://Assets/Sound/bubble pop/Bubble_Pop_SFX_12.wav")
]

var elephantShootSounds: Array[AudioStream] = [
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_1.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_2.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_3.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_4.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_5.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_6.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_7.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_8.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_9.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_10.wav"),
	preload("res://Assets/Sound/elephant shoot/Elephant_Pew_SFX_11.wav")
]

var menu_music_volume_attenuation  =-3

##Consts for probabilities:
const ExbullesionProb = 15
const NebulleuseProb = 10
const BulleDozerProb = 3
const PiqueNiqueProb = 20
const AutomapiqueProb = 5
const RepiqueProb = 1

##Elephant parameters
var elephant_x = 960
var elephant_speed = 500 ##The elephant's speed
var elephant_bubble_count = 1 ##The number of bubbles shot per space press
var elephant_angle = 90 ##The elephant's trunk angle
var elephant_angle_range = 0 ##The max angle at which the elephant's trunk can rotate
var elephant_powerups = ["Exbullession"] ##Lists the powerups acquired by the elephant
var elephant_luck = 1


# Bee attributes
var bee_speed = 20 # Default 15
var bee_size = 0.05 # Default 0.05
var bee_powerups = ["Compiquation"] # Powerups acquired by the bee
var bee_luck = 1
var bee_x = 960
var bee_y = 360

var bubble_id = 0
var currently_selected_bubble_id
var bubble_array = []
var speed_bubble = 200
var timer = 60

var is_bubble_selected

func checkIfAcquired(tab, search):
	for i in range(len(tab)):
		if tab[i] == search:
			return true
	return false
	
func getPosition(tab, search):
	for i in range(len(tab)):
		if tab[i] == search:
			return i
	return -1
	
func destroy_bubble(x):
	x.bubble_properties["is_alive"] = false
	if global.currently_selected_bubble_id != null:
		if global.bubble_array[global.currently_selected_bubble_id].bubble_properties["is_alive"] == false:
			global.bubble_array[global.currently_selected_bubble_id].bubble_instance.visible = false
	if global.checkIfAcquired(global.bee_powerups, "Compiquation"):
		global.bee_speed *= 0.95

func probability(min, mod):
	var number = randi_range(0, 100)
	if number < min * mod:
		return true
	return false
