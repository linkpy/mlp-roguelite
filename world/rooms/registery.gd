### \description Room registery.
###
class_name RoomRegistery
extends Object



### \description Earth area rooms
const Earth = [
	preload("./earth/earth_3x2.tres"),
	preload("./earth/earth_3x3.tres"),
	preload("./earth/earth_4x2.tres"),
]



############################################################
### \description Creates a room pool from the given array.
###
static func make_pool(l: Array) -> RoomPools:
	var pool = RoomPools.new()
	
	for rd in l:
		pool.add_room(rd)
	
	return pool

############################################################
### \description Creates a room pool for the Earth area.
###
static func make_earth_pool() -> RoomPools:
	return make_pool(Earth)
