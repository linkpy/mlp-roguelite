### \description A room instance.
###
### A room instance is a room definition with a position
### and connections to adjacent rooms.
###
class_name RoomInstance
extends Reference



### \description The room's definition.
var definition: RoomDefinition
### \description The room's position.
var position: Vector2
### \description The room's connections.
var connections: Array
### \description True if this instance is an area transition
var area_transition: bool



###################################################### _init
func _init(d: RoomDefinition, p: Vector2) -> void:
	definition = d
	position = p
	connections = []
	area_transition = false
	
	_init_connections()

############################################################
### \description Initializes the room's connection list.
###
func _init_connections():
	connections.resize(definition.doors.size())
	
	for i in range(definition.doors.size()):
		connections[i] = null



############################################################
### \description Checks if a room is connected to the given
###              door.
###
func has_connection(door_idx: int) -> bool:
	if door_idx < 0 or door_idx >= connections.size():
		printerr("Door index out of range.")
		assert(false)
		return false
	
	return connections[door_idx] != null

############################################################
### \description Gets the room connected to the given door.
###
func get_connection(door_idx: int):
	if door_idx < 0 or door_idx >= connections.size():
		printerr("Door index out of range.")
		assert(false)
		return null
	
	if not has_connection(door_idx):
		printerr("No connection for the given door index.")
		assert(false)
		return null
	
	return connections[door_idx]

############################################################
### \description Connects the given room to the given door.
###
func connect_room(door_idx: int, r):
	if door_idx < 0 or door_idx >= connections.size():
		printerr("Door index out of range.")
		assert(false)
		return null
	
	if has_connection(door_idx):
		printerr("A connection is already made with this door index.")
		assert(false)
		return null
	
	connections[door_idx] = r
	return self



############################################################
### \description Gets the room instance's rectangle.
###
func get_rectangle() -> Rect2:
	return Rect2(
		position,
		definition.size
	)



############################################################
### \description Checks if the room has rooms connected to
###              its entry.
###
func is_first_room() -> bool:
	for di in definition.doors.size():
		var d = definition.doors[di]
		
		if d.direction == RoomDoorDefinition.Direction.Entry:
			if has_connection(di):
				return false
	
	return true

############################################################
### \description Checks if the room has branching.
###
func is_branching() -> bool:
	return definition.is_branching()

############################################################
### \description Checks if the room doesn't have any rooms
###              connected to its exit.
###
func is_end_room() -> bool:
	for di in definition.doors.size():
		var d = definition.doors[di]
		
		if d.direction == RoomDoorDefinition.Direction.Exit:
			if has_connection(di):
				return false
	
	return true
