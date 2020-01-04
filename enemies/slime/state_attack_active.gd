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



### \description True if the player was already damaged.
var attack_done: bool = false



###################################################### enter
func enter(_data) -> void:
	var direction = 1
	
	if object.sprite.flip_h:
		direction = -1
	
	
	object.animation.stop()
	object.sprite.animation = "attack_active"
	object.sprite.frame = 0
	object.sprite.flip_h = false
	
	object.impulse( 
		Vector2(1, 0).rotated(-PI/6) * Vector2(direction, 1),
		object.stats.get_jump_force()
	)
	
	attack_done = false


########################################### _physics_process
func _physics_process(dt: float) -> void:
	if not attack_done and _check_for_player():
		attack_done = true
		object.player.apply_damages(
			object,
			object.stats.get_attack()
		)
	
	if object.velocity.y <= -1.5:
		object.sprite.frame = 0
	elif abs(object.velocity.y) < 1.5:
		object.sprite.frame = 1
	elif object.velocity.y >= 1.5:
		object.sprite.frame = 2
	
	object.move(dt, true)
	
	if object.is_on_floor():
		controller.state = "attack_recovery"



############################################################
### \description Check if the slime hits the player.
###
func _check_for_player() -> bool:
	var dss = object.get_world_2d().direct_space_state
	var hit = dss.intersect_ray(
		object.position, object.position + Vector2(1,1),
		[], 0x2
	)
	
	if not hit.empty():
		if hit.collider.is_in_group("player"):
			return true
	
	return false
