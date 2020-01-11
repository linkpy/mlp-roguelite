### \description Level master script.
###
class_name Level
extends Node2D



### \description Tilemap of the level.
onready var tilemap: TileMap = $map

### \description AStar2D instance.
var astar: AStar2D = null
### \description Room list, only set when the debug is enabled.
var rooms: Array = []



### \description emitted when the level is loaded.
signal loaded()



##################################################### _ready
func _ready() -> void:
	_pre_ready()
	
	var start_time = OS.get_ticks_usec()
	var gen = AStarGenerator.new(tilemap)
	
	astar = gen.generate()
	print(
		"AStarGenerator: took ", 
		(OS.get_ticks_usec() - start_time),
		"usec to generate the AStar2D mesh."
	)
	
	update()
	emit_signal("loaded")

############################################################
### \description Called before _ready.
### 
func _pre_ready() -> void:
	pass


###################################################### _draw
func _draw():
	if Constants.PathfindingDebug:
		return
	
	for pt in astar.get_points():
		draw_circle(
			astar.get_point_position(pt),
			4,
			Color.magenta
		)
		
		for lpt in astar.get_point_connections(pt):
			draw_line(
				astar.get_point_position(pt),
				astar.get_point_position(lpt),
				Color.magenta,
				1
			)



############################################################
### \description Get a path using the A* pathfinder.
###
func get_astar_path(from: Vector2, to: Vector2):
	var fid = astar.get_closest_point(from)
	var tid = astar.get_closest_point(to)
	
	return Array(astar.get_point_path(fid, tid))
