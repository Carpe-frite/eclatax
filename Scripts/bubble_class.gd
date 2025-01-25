class_name bubble_class

var bulle = preload("res://bulle.tscn")
var bubble_instance
var bubble_properties

func _init() -> void:
	bubble_instance = bulle.instantiate()
	bubble_properties = {"x" : global.elephant_x+100, "y" : 692, "is_alive" : true}
	bubble_instance.set_global_position(Vector2(bubble_properties["x"], bubble_properties["y"]))
	global.bubble_array.append(self)
	
func go_up(delta):
	pass
	
func die():
	pass
	
func _ready():
	pass
	
func _process(delta: float) -> void:
	go_up(delta)
