extends Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Timer properties init
	global.timer = 2
	
	if global.checkIfAcquired(global.elephant_powerups, "Bulln-Out"):
		global.timer *= 1.5
	if global.checkIfAcquired(global.bee_powerups, "Flegmapique"):
		global.speed_bubble *= 0.5
	if global.checkIfAcquired(global.bee_powerups, "Expiqueration"):
		global.timer *= 0.9
	
	self.set_wait_time(global.timer) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
