### \description Init Attack state of the slime.
###
### \note The state is entered when the state `chase` 
###       detects the player to be close enough.
###
### \note The state is exited when the animation 
###       'attack_init'is finished. The animation player
###       switches the state throught a function call track.
###
extends FSM_State



###################################################### enter
func enter(_data) -> void:
	object.animation.play("attack_init")
	object.velocity.x = 0
	
	if object.player.position.x < object.position.x:
		object.sprite.flip_h = true
	else:
		object.sprite.flip_h = false



########################################### _physics_process
func _physics_process(dt: float) -> void:
	object.move(dt)
