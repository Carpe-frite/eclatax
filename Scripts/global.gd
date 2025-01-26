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


func get_full_path(folderName, file):
	return "res://Assets/Sound/" + folderName + "/" + file

func get_chord_progression(folderName):
	var dir = DirAccess.open("res://Assets/Sound/" + folderName)
	var soundArray = []
	var chordProgression: Array = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if (!file_name.contains("import")):
				print("Found file: " + file_name)

				soundArray.append(get_full_path(folderName, file_name))
			file_name = dir.get_next()
	
	var chord_1 = [
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "1.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "3.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "5.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "8.wav"))]),
	]
	
	var chord_2 = [
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "2.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "4.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "6.wav"))]),
	]
	
	var chord_3 = [
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "5.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "7.wav"))]),
		load(soundArray[soundArray.bsearch(get_full_path(folderName, "2.wav"))]),
	]
	
	chordProgression = [
		chord_1,
		chord_2,
		chord_3,
		chord_1,
		
		chord_1,
		chord_2,
		chord_3,
		chord_1,
		
		chord_3,
		chord_1,
		chord_3,
		chord_1,
		
		chord_2,
		chord_1,
		chord_3,
		chord_3,
		
		chord_3,
	]
	
	return chordProgression

func get_random_note(bank, chord_number):
	var chord = bank[chord_number]
	var size = chord.size()
	
	return chord[randi() % size]

var menu_music_volume_attenuation  =-3

#Bonus effects


##Consts for probabilities:
const ExbullesionProb = 10
const NebulleuseProb = 5
const BulleDozerProb = 2
const PiqueNiqueProb = 5
const AutomapiqueProb = 5
const RepiqueProb = 1

##Elephant parameters
var elephant_x
var elephant_speed ##The elephant's speed
var elephant_bubble_count ##The number of bubbles shot per space press
var elephant_angle ##The elephant's trunk angle
var elephant_angle_range ##The max angle at which the elephant's trunk can rotate
var elephant_powerups = ["Ambullence"] ##Lists the powerups acquired by the elephant
var elephant_luck = 1

var surpobullation = {"name" : "surpobullation", "weight" : 10, "desc" : "Bulles par tir +1" , "image" : "res://Assets/Bonus/Surpobullation.png", "effect" : 0}
var nebulleuse = {"name" : "nébulleuse", "weight" : 10, "desc" : "Bulle éclatée, 10% de chances: Crée 5 bulles autour" , "image" : "res://Assets/Bonus/Nebulleuse.png", "effect" : 1}
var probullession = {"name" : "Probullession", "weight" : 20, "desc" : "Vitesse des bulles +33%" , "image" : "res://Assets/Bonus/Probullession.png", "effect" : 2}

var elephant_effects_array = [surpobullation, nebulleuse, probullession]

# Bee attributes
var bee_speed
var bee_size
var bee_powerups = ["Hypothepique","Automapique"] # Powerups acquired by the bee
var bee_luck = 1
var bee_x = 960
var bee_y = 360
var bee_cripique_active

var bubble_id = 0
var currently_selected_bubble_id
var currently_selected_bubble_ids = []
var bubble_array = []
var speed_bubble = 200
var bubble_size
var timer

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
	x.bubble_instance.visible = false
	"""if global.currently_selected_bubble_ids.is_empty() == false:
		for y in global.currently_selected_bubble_ids:
			if global.bubble_array[y].bubble_properties["is_alive"] == false:
				global.bubble_array[y].bubble_instance.visible = false"""
	if global.checkIfAcquired(global.bee_powerups, "Compiquation"):
		global.bee_speed /= 1.05
	if global.checkIfAcquired(global.elephant_powerups, "Ambullence"):
		global.speed_bubble *= 1.01

func probability(min, mod):
	var number = randi_range(0, 100)
	if number < min * mod:
		return true
	return false
