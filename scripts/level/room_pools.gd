### \description Room manager working with size-based pools.
###
class_name RoomPools
extends Reference



### \description Pools of the room manager.
var pools: Dictionary



###################################################### _init
func _init() -> void:
	pools = {}



############################################################
### \description Checks if a pools exists for the given 
###              room size.
###
func has_pool_for_size(s: Vector2) -> bool:
	return pools.has(s.floor())

############################################################
### \description Checks if rooms exists with the given room
###              size.
###
func has_rooms_with_size(s: Vector2) -> bool:
	return has_pool_for_size(s)

############################################################
### \description Checks if rooms exists with the given door.
###
func has_rooms_with_door(d: int, s: int) -> bool:
	return get_rooms_with_door(d, s).size() != 0

############################################################
### \description Checks if rooms exists which fits the given
###              size.
###
func has_rooms_fitting_in(ms: Vector2) -> bool:
	return get_rooms_fitting_in(ms).size() != 0

############################################################
### \description Checks if rooms exists with the given door
###              and which fits the given size.
###
func has_rooms_with_door_fitting_in(d: int, s: int, ms: Vector2) -> bool:
	return get_rooms_with_door_fitting_in(d, s, ms).size() != 0



############################################################
### \description Adds a room to the pool.
###
func add_room(r: RoomDefinition):
	if has_pool_for_size(r.size):
		pools[r.size.floor()].push_back(r)
	else:
		pools[r.size.floor()] = [r]
	
	return self



############################################################
### \description Get all available size which fits the given 
###              maximum size.
###
func get_available_sizes(max_size: Vector2 = Vector2(INF, INF)) -> Array:
	var res = []
	
	for s in pools.keys():
		if s.x <= max_size.x and s.y <= max_size.y:
			res.push_back(s)
	
	return res



############################################################
### \description Gets all rooms with the given size.
###
func get_rooms_with_size(s: Vector2) -> Array:
	if has_pool_for_size(s):
		return pools[s.floor()]
	
	return []

############################################################
### \description Gets all rooms with the given door.
###
func get_rooms_with_door(d: int, s: int) -> Array:
	var res = []
	
	for rl in pools.values():
		for r in rl:
			if r.has_door_on_side(d, s):
				res.push_back(r)
	
	return res

############################################################
### \description Gets all rooms fitting the given size.
###
func get_rooms_fitting_in(ms: Vector2) -> Array:
	var ss = get_available_sizes(ms)
	var res = []
	
	for s in ss:
		for r in get_rooms_with_size(s):
			res.push_back(r)
	
	return res

############################################################
### \description Gets all rooms with a door and fitting
###              the given size.
###
func get_rooms_with_door_fitting_in(d: int, s: int, ms: Vector2) -> Array:
	var ss = get_available_sizes(ms)
	var res = []
	
	for s in ss:
		for r in get_rooms_with_size(s):
			if r.has_door_on_side(d, s):
				res.push_back(r)
	
	return res



############################################################
### \description Gets a random room with the given size.
###
func get_random_room_with_size(s: Vector2) -> RoomDefinition:
	var l = get_rooms_with_size(s)
	
	if l.size() == 0:
		return null
	
	return l[randi() % l.size()]

############################################################
### \description Gets a random room with the given door.
###
func get_random_room_with_door(d: int, s: int) -> RoomDefinition:
	var l = get_rooms_with_door(d, s)
	
	if l.size() == 0:
		return null
	
	return l[randi() % l.size()]

############################################################
### \description Gets a random room fitting the given size.
###
func get_random_room_fitting_in(ms: Vector2) -> RoomDefinition:
	var l = get_rooms_fitting_in(ms)
	
	if l.size() == 0:
		return null
	
	return l[randi() % l.size()]

############################################################
### \description Gets a random room with the given door and
###              fitting the given size.
###
func get_random_room_with_door_fitting_in(d: int, s: int, ms: Vector2) -> RoomDefinition:
	var l = get_rooms_with_door_fitting_in(d, s, ms)
	
	if l.size() == 0:
		return null
	
	return l[randi() % l.size()]
