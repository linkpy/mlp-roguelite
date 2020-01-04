### \description Active Attack state of the slime.
###
### \note The state is entered when the animation 
###       `attack_init` is finished. The animation player
###       changes the state from a function call track.
###
### \note The state is exited when the slime touches the
###       the ground.
###
extends FSM_State



###################################################### enter
func enter(_data) -> void:
	var direction = sign(
		  object.player.position.x
		- object.position.x
	)
	
	object.animation.stop()
	object.sprite.animation = "attack_active"
	object.sprite.frame = 0
	
	object.impulse( 
		Vector2(1, 0).rotated(-PI/6) * Vector2(direction, 1),
		object.stats.get_jump_force()
	)


########################################### _physics_process
func _physics_process(dt: float) -> void:
	if object.velocity.y <= -1.5:
		object.sprite.frame = 0
	elif abs(object.velocity.y) < 1.5:
		object.sprite.frame = 1
	elif object.velocity.y >= 1.5:
		object.sprite.frame = 2
	
	object.move(dt, true)
	
	if object.is_on_floor():
		controller.state = "attack_recovery"
