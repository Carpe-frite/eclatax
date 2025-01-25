class_name bee_class
extends Node2D

@onready var bee = self
@onready var animated_bee = $AnimatedSprite2D

# Global
var delta_time = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if global.checkIfAcquired(global.bee_powerups, "Precipiquation"):
		global.bee_speed *= 2
	if global.checkIfAcquired(global.bee_powerups, "Piquantesque"):
		global.bee_size *= 1.75
	if global.checkIfAcquired(global.bee_powerups, "Frenepique"):
		global.bee_size *= 0.5
		global.bee_speed *= 5
	if global.checkIfAcquired(global.bee_powerups, "Flegmapique"):
		global.speed_bubble *= 0.5
	if global.checkIfAcquired(global.bee_powerups, "Expiqueration"):
		global.timer *= 0.9
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_time = delta
	
	set_bee_size(global.bee_size)
	# set_bee_speed()
	
	animated_bee.play("default")

# Called whenever there is an input event
func _input(event):
	var border_spacing = 50
	bee.position.x = global.bee_x
	bee.position.y = global.bee_y
	if(global.bee_x < border_spacing):
		global.bee_x = border_spacing
	if(global.bee_x > 1920 - border_spacing):
		global.bee_x = 1920 - border_spacing
	if(global.bee_y < border_spacing):
		global.bee_y = border_spacing
	if(global.bee_y > 1080 - border_spacing):
		global.bee_y = 1080 - border_spacing
	if event is InputEventMouseMotion:
		global.bee_x += event.relative.x * global.bee_speed * delta_time
		global.bee_y += event.relative.y * global.bee_speed * delta_time

# Setters
func set_bee_size(new_size):
	animated_bee.scale = Vector2(new_size, new_size)

func set_bee_speed(new_speed):
	global.bee_speed = new_speed
