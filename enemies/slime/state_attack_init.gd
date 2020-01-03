extends FSM_State



###################################################### enter
func enter(data) -> void:
	object.animation = "attack_init"
	
	if object.player.position.x < object.position.x:
		object.sprite.flip_h = true
	else:
		object.sprite.flip_h = false

####################################################### exit
func exit() -> void:
	object.sprite.flip_h = false



########################################### _physics_process
func _physics_process(dt: float) -> void:
	object.move(dt)
