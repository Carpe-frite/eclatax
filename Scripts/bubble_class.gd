extends Node2D

class_name bubble_class

var bulle = preload("res://bulle.tscn")
var bubble_instance
var bubble_properties

func _init() -> void:
	bubble_instance = bulle.instantiate()
	bubble_properties = {"x" : global.elephant_x+100, "y" : 692, "is_alive" : true}
	bubble_instance.set_global_position(Vector2(bubble_properties["x"], bubble_properties["y"]))
	global.bubble_array.append(self)
	var test = "oui"

func bubble_action():
	if Input.is_action_just_released("ui_kb_Space"):
		var new_bubble = bubble_class.new()
		self.add_child(global.bubble_array[global.bubble_id].bubble_instance)
		global.bubble_id += 1
		
func bubbles_go_up(delta):
	for x in global.bubble_array:
		x.bubble_properties["y"] = x.bubble_properties["y"] - global.speed_bubble * delta
		x.bubble_instance.set_global_position(Vector2(x.bubble_properties["x"],x.bubble_properties["y"]))

func _ready():
	pass
	
func _process(delta: float) -> void:
	bubble_action()
	bubbles_go_up(delta)
