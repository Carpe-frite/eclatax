class_name bubble_class

var bulle = preload("res://bulle.tscn")
var bubble_instance

func _init() -> void:
	bubble_instance = bulle.instantiate()
	global.bubble_array.append(bubble_instance)
	
func _ready():
	pass
	
func _process():
	pass
