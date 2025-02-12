extends Node2D

var id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_id(val):
	id = val

func _on_character_body_2d_area_entered(area: Area2D) -> void:
	if global.checkIfAcquired(global.bee_powerups, "Automapique") and global.probability(global.AutomapiqueProb, global.bee_luck):
		global.destroy_bubble(global.bubble_array[id])
	else:
		global.is_bubble_selected = true
		#global.currently_selected_bubble_id = id
		global.currently_selected_bubble_ids.append(id)
	

func _on_character_body_2d_area_exited(area: Area2D) -> void:
	global.is_bubble_selected = false
	#global.currently_selected_bubble_id = null
	global.currently_selected_bubble_ids.erase(id)
