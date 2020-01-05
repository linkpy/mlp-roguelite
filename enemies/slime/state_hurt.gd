### \description Hurt state of the slime.
###
### \note The state is entered when the slime takes damage.
###
### \note The state is exited when the animation "hurt" is
###       finished. The animation player switched state by
###       using a function call track.
###
extends FSM_State



### \description Impulse applied as knockback.
export var impulse: float = 10



###################################################### enter
func enter(_d):
	object.animation.play("hurt")
	
	var pl_pos = object.player.position
	var obj_pos = object.position
	var dir = 1
	
	if pl_pos.x > obj_pos.x:
		object.sprite.flip_h = true
		dir = -1
	
	object.impulse( 
		Vector2(1, 0).rotated(-PI/6) * Vector2(dir, 1),
		impulse
	)



########################################### _physics_process
func _physics_process(dt: float):
	object.move(dt)
	
	if object.is_on_floor():
		object.velocity.x = 0
