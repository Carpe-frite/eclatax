extends Node

var bee_speed = 15
var delta_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta_time = delta

# Called whenever there is an input event
func _input(event):
	if event is InputEventMouseMotion:
		$sprite_bee.position += event.relative * bee_speed * delta_time
