extends Node

var round_number = 1 ##The current round
var elephant_won

var elephant_rounds_won = 0
var bee_rounds_won = 0

##Elephant parameters
var elephant_x = 960
var elephant_speed = 500 ##The elephant's speed
var elephant_bubble_count = 1 ##The number of bubbles shot per space press
var elephant_angle = 90 ##The elephant's trunk angle
var elephant_angle_range = 0 ##The max angle at which the elephant's trunk can rotate
var elephant_powerups = ["Bulln-Out"] ##Lists the powerups acquired by the elephant
var elephant_luck = 1


# Bee attributes
var bee_speed = 20 # Default 15
var bee_size = 0.05 # Default 0.05
var bee_powerups = ["Compiquation"] # Powerups acquired by the bee
var bee_luck = 1

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
