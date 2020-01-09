### \description Room definition.
###
### A room is defined using two parameters :
###  1. Size : The size of the room, in tiles.
###  2. Doors : The list of entry/exit doors of the room.
###  
class_name RoomDefinition
extends Resource



### \description The side of the room.
export(Vector2) var size: Vector2
### \description The doors of the room.
export(Array) var doors: Array
### \description The room's render template.
export(PackedScene) var render_template: PackedScene



###################################################### _init
# shouldn't be needed
#func _init(s: Vector2, ds: Array = []) -> void:
#	size = s
#	doors = ds



############################################################
### \description Adds a door to the room.
###
### \param d : Direction of the door.
### \param s : Side of the room on which the door is.
### \param p : Position of the door on the side.
###
func add_door(d: int, s: int, p: int):
	var door = RoomDoorDefinition.new()
	door.direction = d
	door.side = s
	door.position = p
	
	doors.push_back(
		door
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
		if door.direction == d and door.side == s:
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
		if door.direction == d and door.side == s:
			res.push_back(door)
	
	return res
