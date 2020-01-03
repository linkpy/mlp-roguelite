extends FSM_State


### \description Player attack range.
export var player_attack_range: float = 96



###################################################### enter
func enter(data) -> void:
	object.animation.play("chase")
	object.sprite.flip_h = false



########################################### _physics_process
func _physics_process(dt: float):
	var pl_pos = object.player.position
	var obj_pos = object.position
	
	object.velocity.x = (
		sign(pl_pos.x - obj_pos.x) * object.movement_speed
	)
	
	object.move(dt)
	
	if obj_pos.distance_to(pl_pos) <= player_attack_range:
		controller.state = "attack_init"
