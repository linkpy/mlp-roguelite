### \description Room definition.
###
### A room is defined using two parameters :
###  1. Size : The size of the room, in tiles.
###  2. Doors : The list of entry/exit doors of the room.
###  
class_name RoomDefinition
extends Reference



### \description The side of the room.
var size: Vector2
### \description The doors of the room.
var doors: Array



###################################################### _init
func _init(s: Vector2, ds: Array = []) -> void:
	size = s
	doors = ds



############################################################
### \description Adds a door to the room.
###
### \param d : Direction of the door.
### \param s : Side of the room on which the door is.
### \param p : Position of the door on the side.
###
func add_door(d: int, s: int, p: int):
	doors.push_back(
		RoomDoorDefinition.new(d, s, p)
	)
	
	return self



############################################################
### \description Checks if a door is present on the given
###              side with the given direction.
###
### \param d : Direction of the door.
### \param s : Side of the door.
###
func has_door_on_side(d: int, s: int) -> bool:
	for door in doors:
		if door.dir == d and door.side == s:
			return true
	
	return false

############################################################
### \description Gets all of the doors on the given side
###              with the given direction.
###
### \param d : Direction of the door.
### \param s : Side of the door.
###
func get_doors_on_side(d: int, s: int) -> Array:
	var res = []
	
	for door in doors:
		if door.dir == d and door.side == s:
			res.push_back(door)
	
	return res
