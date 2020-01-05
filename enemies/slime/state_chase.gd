### \description Chase state of the slime.
###
### \note The state is entered when the player is detected
###       by the slime (`player_sighted` signal emitted).
###
### \note The state is exited when the player is close 
###       enough to start the attack.
###
extends FSM_State



### \description Player attack range.
export var player_attack_range: float = 96

var path = []



###################################################### enter
func enter(_data) -> void:
	path = []
	
	object.animation.play("chase")
	object.sprite.flip_h = false



################################################### _process
func _process(dt: float):
	path = object.level.get_astar_path(
		object.position,
		object.player.position
	)

########################################### _physics_process
func _physics_process(dt: float):
	if path.size() == 0:
		return
	
	var obj_pos = object.position
	var pl_pos = object.player.position
	var next_point = _get_next_point_in_path()
	
	if next_point.x < obj_pos.x:
		object.velocity.x = -object.stats.get_movement_speed()
	else:
		object.velocity.x = object.stats.get_movement_speed()
	
	if next_point.y < obj_pos.y - 8 and object.is_on_floor():
		object.impulse(Vector2(0, -1), object.stats.get_jump_force())
	
	object.move(dt)
	
	
	if obj_pos.distance_to(pl_pos) <= player_attack_range:
		controller.state = "attack_init"



func _get_next_point_in_path():
	if path.size() == 1:
		return path[0]
	
	var obj_pos = object.position
	var pl_pos = object.player.position
	
	var pt0 = path[0]
	var pt1 = path[1]
	
	if pl_pos.x < obj_pos.x:
		if pt0.x > obj_pos.x:
			return pt1
	if pl_pos.x > obj_pos.x:
		if pt0.x < obj_pos.x:
			return pt1
	
	if abs(pt0.x - obj_pos.x) < 3:
		return pt1
	
	return pt0
