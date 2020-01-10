### \description Level generation context
###
### Contains the occurence count of each room.
###
class_name LevelGenerationContext
extends Reference



### \description Occurences of each room
var room_occurences: Dictionary



###################################################### _init
func _init() -> void:
	room_occurences = {}



############################################################
### \description Impots rooms from the given pool.
###
func import_pool(rp: RoomPools) -> void:
	for rl in rp.pools.values():
		for r in rl:
			room_occurences[r] = 0



############################################################
### \description Adds an occurence for the given room.
###
func add_occurence(rdef: RoomDefinition) -> void:
	if room_occurences.has(rdef):
		room_occurences[rdef] += 1
	else:
		room_occurences[rdef] = 1

############################################################
### \description Gets the occurence count for the given 
###              room.
###
func get_occurence_count(rdef: RoomDefinition) -> int:
	if room_occurences.has(rdef):
		return room_occurences[rdef]
	else:
		return 0

############################################################
### \description Gets the average occurence count.
###
func get_average_occurence_count() -> float:
	if room_occurences.size() == 0:
		return 0.0
	
	var count = 0
	
	for c in room_occurences.values():
		count += c
	
	return float(count) / room_occurences.size()
