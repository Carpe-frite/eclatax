class_name Elephant
extends Node


@onready var acteur_elephant = self
@onready var sprite_elephant = $AnimatedSprite2D

func _ready() -> void:
	##Elephant properties init
	global.elephant_x = 960
	global.elephant_speed = 500 ##The elephant's speed
	global.elephant_bubble_count = 1 ##The number of bubbles shot per space press
	global.elephant_angle = 90 ##The elephant's trunk angle
	global.elephant_angle_range = 0 ##The max angle at which the elephant's trunk can rotate
	global.elephant_luck = 1
	
	
	# On peux le passer dans une fonction
	if global.checkIfAcquired(global.elephant_powerups, "Surpobullation"):
		global.elephant_bubble_count += 1
	if global.checkIfAcquired(global.elephant_powerups, "Deambulle"):
		global.elephant_speed *= 1.5
	if global.checkIfAcquired(global.elephant_powerups, "Probabullite"):
		global.elephant_luck *= 2

func move_elephant(delta):
	if Input.is_action_pressed("ui_kb_MoveElephantRight"):
		if global.elephant_x <= 1820:
			global.elephant_x += global.elephant_speed * delta
			acteur_elephant.set_global_position(Vector2(global.elephant_x,0))
	if Input.is_action_pressed("ui_kb_MoveElephantLeft"):
		if global.elephant_x >= 100:
			global.elephant_x -= global.elephant_speed * delta
			acteur_elephant.set_global_position(Vector2(global.elephant_x,0))

func shoot_bubble_animation():
	if Input.is_action_pressed("ui_kb_Space"):
		sprite_elephant.play("shoot")
	else: 
		sprite_elephant.play("default")

func _process(delta: float) -> void:
	move_elephant(delta)
	shoot_bubble_animation()
