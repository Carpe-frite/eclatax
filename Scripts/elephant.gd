class_name Elephant
extends Node2D


@onready var acteur_elephant = self
@onready var sprite_elephant = $AnimatedSprite2D

@onready var elephantSoundPlayer = get_node("ElephantShootSoundPlayer")

func _ready() -> void:
	
	# On peux le passer dans une fonction
	if global.checkIfAcquired(global.elephant_powerups, "Surpobullation"):
		global.elephant_bubble_count += 1
	if global.checkIfAcquired(global.elephant_powerups, "Probullession"):
		global.speed_bubble *= 1.33
	if global.checkIfAcquired(global.elephant_powerups, "Deambulle"):
		global.elephant_speed *= 1.5
	if global.checkIfAcquired(global.elephant_powerups, "Bulln-Out"):
		global.timer *= 1.5
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
		elephantSoundPlayer.stream = global.elephantShootSounds[randi() % 11]
		elephantSoundPlayer.play()
		sprite_elephant.play("shoot")
	else: 
		sprite_elephant.play("default")

func _process(delta: float) -> void:
	move_elephant(delta)
	shoot_bubble_animation()
