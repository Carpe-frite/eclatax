class_name bee_class
extends Node2D

@onready var sprite_bee = get_node("Area2D/CollisionPolygon2D/sprite_bee")

# Bee attributes
var bee_speed = 150 # Default 15
var bee_size = 0.05 # Default 0.05

# Global
var delta_time = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_time = delta
	set_bee_size(bee_size)
	# set_bee_speed()

# Called whenever there is an input event
func _input(event):
	if event is InputEventMouseMotion:
		self.position.x += event.relative.x * bee_speed * delta_time
		self.position.y += event.relative.y * bee_speed * delta_time

# Setters
func set_bee_size(new_size):
	sprite_bee.scale = Vector2(new_size, new_size)

func set_bee_speed(new_speed):
	bee_speed = new_speed
