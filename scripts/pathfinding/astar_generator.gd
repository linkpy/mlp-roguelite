### \description AStar2D instance generator working with 
###              a Convolution instance to generate at 
###              runtime a suitable AStar2D instance for the
###              given TileMap.
###
class_name AStarGenerator
extends Reference



### \description TileMap used by the generator
var tilemap: TileMap
### \description Convolution instance.
var convolution: Convolution
### \description AStar2D instance.
var astar: AStar2D
### \description Dictionary of AStar nodes.
var ids: Dictionary



###################################################### _init
func _init(tm: TileMap):
	tilemap = tm
	convolution = Convolution.new()
	astar = AStar2D.new()
	ids = {}



############################################################
### \description Generates the AStar2D mesh.
###
func generate() -> AStar2D:
	assert(ids.size() == 0)
	
	var positions = _generate_nodes()
	_setup_convolution()
	
	convolution.process(positions)
	_correct_nodes_positions()
	
	return astar



############################################################
### \description Generate the AStar2D nodes on top of 
###              walkable tiles.
###
func _generate_nodes() -> Array:
	var positions = []
	
	for pos in tilemap.get_used_cells():
		var ppos = pos + Vector2(0, -1)
		
		if tilemap.get_cellv(ppos) == -1:
			positions.push_back(ppos)
	
	var id = 0
	for pos in positions:
		ids[pos] = id
		astar.add_point(id, pos)
	
	return positions

############################################################
### \description Corrects the nodes position to be world
###              position instead of tile positions.
###
func _correct_nodes_positions() -> void:
	var csize = tilemap.cell_size
	
	for pos in ids.keys():
		astar.set_point_position(
			ids[pos],
			pos * csize + csize/2
		)



############################################################
### \description Setup the convolution algorithm.
###
func _setup_convolution() -> void:
	_add_convolution_inputs()
	_add_convolution_checkers()

############################################################
### \description Adds the different input layers to the 
###              convolution algorithm.
###
func _add_convolution_inputs() -> void:
	convolution.add_input(
		ConvolutionTileMapInput.new(tilemap)
	)
	convolution.add_input(
		_astar_node_input.new(ids)
	)

############################################################
### \description Adds the different pattern checker to the
###              convolution algorithm.
###
func _add_convolution_checkers() -> void:
	_add_convolution_grid_checker(
		[ "   ",
		  "BBB", 
		  "AAA" ],
		funcref(self, "_callback_link_left_and_right")
	)
	_add_convolution_grid_checker_with_hflip(
		[ "   ",
		  "BBb",
		  "AA " ],
		funcref(self, "_callback_link_left_or_right")
	)
	_add_convolution_grid_checker_with_hflip(
		[ "Ba ",
		  "AB ",
		  " A " ],
		funcref(self, "_callback_link_1up_1hor")
	)
	_add_convolution_grid_checker_with_hflip(
		[ " Ba  ",
		  " Aa  ",
		  "  B  ",
		  "  A  ",
		  "     " ],
		funcref(self, "_callback_link_2up_1hor")
	)

############################################################
### \description Adds a grid checker to the convolution
###              instance.
###
func _add_convolution_grid_checker(g: Array, cb: FuncRef, h = null):
	var grid = ConvolutionGridChecker.new(g)
	convolution.add_checker(grid, cb, h)

############################################################
### \description Adds a grid checker to the convolution 
###              instance and also the same grid but flipped
###              horizontally.
###
func _add_convolution_grid_checker_with_hflip(g: Array, cb: FuncRef):
	var grid = ConvolutionGridChecker.new(g)
	var flipped = grid.flip_h()
	
	convolution.add_checker(grid, cb, "")
	convolution.add_checker(grid, cb, "f")



############################################################
### \description Links two nodes of the AStar mesh.
###
func _link(a: Vector2, b: Vector2, bdir: bool):
	var aid = ids[a]
	var bid = ids[b]
	astar.connect_points(aid, bid, bdir)



func _callback_link_left_and_right(pos: Vector2, _h):
	_link(pos, pos + Vector2(-1, 0), false)
	_link(pos, pos + Vector2( 1, 0), false)

func _callback_link_left_or_right(pos: Vector2, hint: String):
	if hint == "":
		_link(pos, pos + Vector2(-1, 0), false)
	else:
		_link(pos, pos + Vector2( 1, 0), false)

func _callback_link_1up_1hor(pos: Vector2, hint: String):
	if hint == "":
		_link(pos, pos + Vector2(-1, -1), true)
	else:
		_link(pos, pos + Vector2( 1, -1), true)

func _callback_link_2up_1hor(pos: Vector2, hint: String):
	if hint == "":
		_link(pos, pos + Vector2(-1, -2), true)
	else:
		_link(pos, pos + Vector2( 1, -2), true)



class _astar_node_input extends Convolution.CInput:
	var ids: Dictionary
	
	
	func _init(i: Dictionary):
		ids = i
	
	func get_value(pos: Vector2) -> int:
		if ids.has(pos):
			return ids[pos]
		
		return -1
