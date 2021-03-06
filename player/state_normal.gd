### \description Normal/default state of the player.
###
### \note The state is entered as the default state of the 
###       FSM controller.
###
### \note The state is exited when the player attack or
###       when it receives damages.
###
extends FSM_State



func exit() -> void:
	object.set_collision_mask_bit(10, true)


################################################### _process
func _process(_dt: float) -> void:
	# animation control
	if object.is_on_floor():
		control_walk_animation()
	else:
		pass
	
	# sprite flipping
	if object.velocity.x > 0:
		object.sprite.flip_h = false
	if object.velocity.x < 0:
		object.sprite.flip_h = true



##################################################### _input
func _input( ev: InputEvent ) -> void:
	if object.is_on_floor():
		if ev.is_action_pressed("jump"):
			if Input.is_action_pressed("down"):
				object.set_collision_mask_bit(10, false)
			else:
				object.impulse(
					Vector2(0, -1), 
					object.stats.get_jump_force()
				)
		
		elif ev.is_action_pressed("attack"):
			controller.state = "attack1"
	
	if not object.is_on_floor():
		if ev.is_action_released("down"):
			object.set_collision_mask_bit(10, true)



########################################### _physics_process
func _physics_process( dt: float ) -> void:
	var mov_vec = object.get_movement_input_vector()
	
	object.velocity.x = (
		  mov_vec.x 
		* object.stats.get_movement_speed()
	)
	
	object.move( dt )
	
	if object.is_on_floor():
		object.set_collision_mask_bit(10, true)



############################################################
### \description Controls the walk animation.
###
func control_walk_animation():
	if abs(object.velocity.x) > 0:
		if object.animation.current_animation != "walk":
			object.animation.play("walk")
	else:
		if object.animation.current_animation != "idle":
			object.animation.play("idle")
