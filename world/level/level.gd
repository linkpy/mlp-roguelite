class_name Level
extends Node2D



onready var tilemap: TileMap = $map

var astar: AStar2D = null



func _ready() -> void:
	var gen = AStarGenerator.new(tilemap)
	
	var start_time = OS.get_ticks_usec()
	astar = gen.generate()
	print(
		"AStarGenerator: took ", 
		(OS.get_ticks_usec() - start_time),
		"usec to generate the AStar2D mesh."
	)
	
	update()


func _draw():
	if not Constants.PathfindingDebug:
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
