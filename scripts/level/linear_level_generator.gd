### \description Linear level generator.
###
### This generator just adds random rooms together from left
### to right.
###
class_name LinearLevelGenerator
extends Reference



### \descrtiption Pool of rooms to use.
var pool: RoomPools
### \description Placed rooms
var rooms: Array
### \description Generation context
var context: LevelGenerationContext



###################################################### _init
func _init(p: RoomPools) -> void:
	pool = p
	rooms = []
	context = LevelGenerationContext.new()
	
	context.import_pool(p)



############################################################
### \description Checks if the given point is in a validated
###              room.
###
func is_point_in_room(pt: Vector2) -> bool:
	for ri in rooms:
		if ri.get_rectangle().has_point(pt):
			return true
	
	return false

############################################################
### \description Checks if the given room overlaps any other
###              rooms.
###
func does_room_overlap(ri: RoomInstance) -> bool:
	return does_rect_overlap(ri.get_rectangle())

func does_rect_overlap(r: Rect2) -> bool:
	for ri in rooms:
		if ri.get_rectangle().intersects(r):
			return true
	
	return false



############################################################
### \description Generates the level with a given length.
###
func generate(length: int) -> RoomInstance:
	return _generate_recursive(null, null, length)



############################################################
### \description Recursive generation algorithm.
###
func _generate_recursive(prev: RoomInstance, door: RoomDoorDefinition, length: int) -> RoomInstance:
	# if we are at the end of the generation
	if length == 0:
		if Constants.LevelGenerationDebug:
			print("LevelGeneration: Rejected (length = 0)")
		return null
	
	# room generated in this function
	var room_inst: RoomInstance = null
	
	# if we are generating the first room
	if prev == null:
		room_inst = _generate_first_room()
	# if we are generating a connected room
	else:
		room_inst = _generate_connected_room(prev, door)
	
	if room_inst == null:
		return null
	
	# if the generated room overlaps another room
	if does_room_overlap(room_inst):
		if Constants.LevelGenerationDebug:
			print("LevelGeneration: Rejected (overlap)")
		return null
	
	# we register the room
	rooms.push_back(room_inst)
	
#	if Constants.LevelGenerationDebug:
#		print(
#			"LevelGeneration: Accepted (", 
#			room_inst, 
#			", def : ",
#			room_inst.definition,
#			")"
#		)
		
	# we generate rooms for the exit doors
	_generate_exit_rooms(room_inst, length)
	
	return room_inst

############################################################
### \description Generates the first room of the level.
###
func _generate_first_room() -> RoomInstance:
	return RoomInstance.new(
		pool.get_random_first_room(),
		Vector2()
	)

############################################################
### \description Generates a connected room of the level.
###
func _generate_connected_room(p: RoomInstance, d: RoomDoorDefinition) -> RoomInstance:
	# we reverse the exit door to have the new room entry door
	var rd = d.reverse()
	
	# if no room exists with the entry door
	if not pool.has_rooms_with_door(rd.direction, rd.side):
		return null
	
	# find a fitting room
	var def_and_door = _find_random_room(p, d)
	
	if def_and_door.empty():
		return null
	
	var def = def_and_door[0]
	var door = def_and_door[1]
	
	# we create the room instance
	var inst = RoomInstance.new(def, Vector2())
	
	# we correctly place the room
	inst.position = _compute_room_rect(
		p, d, inst.definition, door
	).position
	
	# connect the room with the previous one
	for door_idx in range(def.doors.size()):
		if def.doors[door_idx] == door:
			inst.connect_room(door_idx, p)
	
	# we return the generated room
	return inst

############################################################
### \description Generates exit rooms.
###
func _generate_exit_rooms(r: RoomInstance, length: int) -> void:
	for i in r.definition.doors.size():
		var door = r.definition.doors[i]
		
		if door.direction == RoomDoorDefinition.Direction.Exit:
			var er = _generate_recursive(r, door, length-1)
			
			if er != null:
				r.connect_room(i, er)



############################################################
### \description Computes the rectangle of a room.
###
### \param pri : Previous room instance.
### \parma prd : Previous room's door connected the new 
###        room.
### \param nrdef : New room's definition
### \param nrd : New room's door connected to the previous 
###        room.
###
func _compute_room_rect(
	pri: RoomInstance, prd: RoomDoorDefinition, 
	nrdef: RoomDefinition, nrd: RoomDoorDefinition
) -> Rect2:
	var r = Rect2()
	
	r.position = (
		  pri.position
		+ prd.get_position_in_space(pri.definition.size)
		- nrd.get_position_in_space(nrdef.size)
		+ prd.get_side_normal()
	)
	r.size = nrdef.size
	
	return r

############################################################
### \description Finds all rooms that can be connected to 
###              the given room which fits the current 
###              layout.
### 
func _find_all_fitting_rooms(pri: RoomInstance, prd: RoomDoorDefinition) -> Array:
	var res = []
	var rev_door = prd.reverse()
	var prooms = pool.get_rooms_with_door(
		rev_door.direction,
		rev_door.side
	)
	
	for room in prooms:
		for door in room.doors:
			var dirok = door.direction == rev_door.direction
			var sideok = door.side == rev_door.side
			
			if dirok and sideok:
				var rect = _compute_room_rect(
					pri, prd, room, door
				)
				
				if not does_rect_overlap(rect):
					res.push_back([room, door])
	
	return res

############################################################
### \description Selects room based by their occurence.
###
func _select_rooms_by_occurences(prooms: Array) -> Array:
	var res = []
	var avg_count = context.get_average_occurence_count()
	
	for room in prooms:
		var occ_count = context.get_occurence_count(room[0])
		
		if occ_count > 0 and room[0].is_special:
			continue
		
		if occ_count < avg_count:
			res.push_back(room)
	
	if res.size() == 0:
		return prooms
	
	return res

############################################################
### \description Find a random room fitting.
###
func _find_random_room(pri: RoomInstance, prd: RoomDoorDefinition) -> Array:
	var prooms = _find_all_fitting_rooms(pri, prd)
	prooms = _select_rooms_by_occurences(prooms)
	
	if prooms.size() == 0:
		if Constants.LevelGenerationDebug:
			print("LevelGeneration: Rejected (no potential room)")
		
		return []
	
	if prooms.size() == 1:
		return prooms[0]
	
	for i in range(prooms.size()):
		if prooms[i][0] == pri.definition:
			prooms.remove(i)
			break
	
	return prooms[randi() % prooms.size()]
