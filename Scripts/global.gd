extends Node

var round_number = 1 ##The current round

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
var bee_powerups = ["Expiqueration"] # Powerups acquired by the bee
var bee_luck = 1

var bubble_id = 0
var bubble_array = []
var speed_bubble = 200
var timer = 60

func checkIfAcquired(tab, search):
	for i in range(len(tab)):
		if tab[i] == search:
			return true
	return false
