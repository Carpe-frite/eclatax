extends Node

var round_number = 1 ##The current round
var elephant_won

var elephant_rounds_won = 0
var bee_rounds_won = 0

var continue_music_at

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
var elephant_powerups = ["Probabullite"] ##Lists the powerups acquired by the elephant
var elephant_luck = 1

var surpobullation = {"name" : "surpobullation", "weight" : 10, "desc" : "Bulles par tir +1" , "image" : "res://Assets/Bonus/Surpobullation.png", "effect" : 0}
var nebulleuse = {"name" : "nébulleuse", "weight" : 10, "desc" : "Bulle éclatée, 10% de chances: Crée 5 bulles autour" , "image" : "res://Assets/Bonus/Nebulleuse.png", "effect" : 1}
var probullession = {"name" : "Probullession", "weight" : 20, "desc" : "Vitesse des bulles +33%" , "image" : "res://Assets/Bonus/Probullession.png", "effect" : 2}

var elephant_effects_array = [surpobullation, nebulleuse, probullession]

# Bee attributes
var bee_speed
var bee_size
var bee_powerups = ["Pique-Nique", "Cripique"] # Powerups acquired by the bee
var bee_luck = 1
var bee_x = 960
var bee_y = 360
var bee_cripique_active

var bubble_id = 0
var currently_selected_bubble_id
var currently_selected_bubble_ids = []
var bubble_array = []
var speed_bubble = 200
var bubble_size = 0.05
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

func probability(min, mod):
	var number = randi_range(0, 100)
	if number < min * mod:
		return true
	return false
