class_name bubble

var bulle = preload("res://bulle.tscn")
var bubble_instance
var bubble_properties

func _init() -> void:
	bubble_instance = bulle.instantiate()
	bubble_instance.set_id(global.bubble_id)
	bubble_properties = {"x" : global.elephant_x, "y" : 692, "is_alive" : true, "id" : global.bubble_id}
	bubble_instance.scale = Vector2(global.bubble_size, global.bubble_size)
	bubble_instance.set_global_position(Vector2(bubble_properties["x"], bubble_properties["y"]))
	global.bubble_array.append(self)
