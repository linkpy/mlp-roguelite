### \description Level generation supervisor.
###
### This class manages and makes sure the level is coherent
### and playable.
###
class_name LevelGenerationSupervisor
extends Reference



### \description List of added rooms.
var rooms: Array



###################################################### _init
func _init():
	rooms = []



############################################################
### \description Adds a rooms to the validated rooms.
###
func add_room(ri: RoomInstance):
	rooms.push_back(ri)
	return self



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
	var r = ri.get_rectangle()
	
	var pts = [
		r.position, r.position + Vector2(r.size.x, 0),
		r.end, r.position + Vector2(0, r.size.y)
	]
	
	for pt in pts:
		if is_point_in_room(pt):
			return true
	
	return false
