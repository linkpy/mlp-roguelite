### \description Linear level generator.
###
### This generator just adds random rooms together from left
### to right.
###
class_name LinearLevelGenerator
extends Reference



### \description Generation supervision.
var supervisor: LevelGenerationSupervisor
### \descrtiption Pool of rooms to use.
var pool: RoomPools



###################################################### _init
func _init(s: LevelGenerationSupervisor, p: RoomPools) -> void:
	supervisor = s
	pool = p



############################################################
### \description
###
func generate(length: int) -> RoomInstance:
	return _generate_recursive(null, null, length)



############################################################
### \description
###
func _generate_recursive(prev: RoomInstance, door: RoomDoorDefinition, length: int) -> RoomInstance:
	# if we are at the end of the generation
	if length == 0:
		return null
	
	# room generated in this function
	var room_inst: RoomInstance = null
	
	# if we are generating the first room
	if prev == null:
		room_inst = _generate_first_room()
	# if we are generating a connected room
	else:
		room_inst = _generate_connected_room(prev, door)
	
	# if the generated room overlaps another room
	if supervisor.does_room_overlap(room_inst):
		return null
	
	# we register the room
	supervisor.add_room(room_inst)
	
	# we generate rooms for the exit doors
	_generate_exit_rooms(room_inst, length)
	
	return room_inst

############################################################
### \description
###
func _generate_first_room() -> RoomInstance:
	return RoomInstance.new(
		pool.get_random_room_with_door(
			RoomDoorDefinition.Direction.Exit,
			RoomDoorDefinition.Side.Right
		),
		Vector2()
	)

############################################################
### \description
###
func _generate_connected_room(p: RoomInstance, d: RoomDoorDefinition) -> RoomInstance:
	# we reverse the exit door to have the new room entry door
	var rd = d.reverse()
	
	# if no room exists with the entry door
	if not pool.has_room_with_door(rd.direction, rd.side):
		return null
	
	# we create the room instance
	var inst = RoomInstance.new(
		pool.get_random_room_with_door(
			rd.direction,
			rd.side
		),
		Vector2()
	)
	
	# we get the list of compatible doors
	var doors = inst.definition.get_doors_on_side(
		rd.direction,
		rd.side
	)
	# we select one at random
	var door = doors[randi() % doors.size()]
	
	# we correctly place the room
	inst.position = (
		  p.position
		+ d.get_position_in_space(p.definition.size)
		- door.get_position(inst.definition.size)
		+ d.get_side_normal()
	)
	
	# we return the generated room
	return inst

############################################################
### \description
###
func _generate_exit_rooms(r: RoomInstance, length: int) -> void:
	for i in r.definition.doors.size():
		var door = r.definition.doors[i]
		
		if door.direction == RoomDoorDefinition.Direction.Exit:
			for j in range(4):
				var er = _generate_recursive(r, door, length-1)
				
				if r != null:
					r.connect_room(i, er)
					break
