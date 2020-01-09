### \description Level rendering node.
###
### Base node used for all level renderer objects.
###
class_name LevelRenderNode
extends Node



### \description Level render target of the node.
var target: LevelRenderTarget setget, get_target
### \description Rendering target area.
var target_rectangle: Rect2 setget, get_target_rect



############################################################
### \description Copies the given tile to the render target.
###
### \param l : tile layer target
### \param t : tile's ID
### \param ac : autotile coordinates
### \param x : X destination coordinate
### \param y : Y destination coordinate
###
func blits_tile(l: int, t: int, ac: Vector2, x: int, y: int):
	var tm = get_target().get_tile_layer(l)
	var tr = get_target_rect()
	
	if x < 0 or x >= tr.size.x or y < 0 or y >= tr.size.y:
		printerr("Out of bound tile rendering.")
		assert(false)
		return
	
	tm.set_cell(
		tr.position.x + x,
		tr.position.y + y,
		t, false, false, false,
		ac
	)

############################################################
### \description Copies the given tilemap to the render 
###              target.
###
### \param l : tile layer target.
### \parma tmn : name of the child tilemap node.
### \param override_empty : true if empty cell should be 
###        copied too.
###
func blits_tiles(l: int, tmn: String, override_empty: bool = false):
	var tm: TileMap = get_node(tmn)
	
	var r = tm.get_used_rect()
	
	for x in range(r.size.x):
		for y in range(r.size.y):
			var xx = r.position.x + x
			var yy = r.position.y + y
			
			var t = tm.get_cell(xx, yy)
			
			if override_empty or t != -1:
				var ac = tm.get_cell_autotile_coord(xx, yy)
				
				blits_tile(
					l, t, ac,
					xx, yy
				)

############################################################
### \description Moves the given object to the given object
###              layer.
###
### \param l : Destination object layer.
### \param on : Object node's name.
###
func move_object(l: int, on: String):
	var ds = get_target().get_object_layer(l)
	var cs = get_target().get_tile_size()
	var dr = get_target_rect()
	var o = get_node(on)
	
	var np = dr.position * cs + o.position
	
	remove_child(o)
	ds.add_child(o)
	o.position = get_target().get_object_new_position(l, np)



############################################################
### \description Checks if the current node is the root
###              of the renderer.
###
func is_renderer_root():
	if get_parent() == null:
		return true
	
	if get_parent().has_method("_render"):
		return false
	
	return true

############################################################
### \description Renders the current node.
###
### \note Overrides `_render` for custom rendering.
###
func render(ri: RoomInstance):
	_render(ri)
	
	for child in get_children():
		if child.has_method("_render"):
			child.render(ri)

############################################################
### \description Custom rendering code of the current node.
###
func _render(ri: RoomInstance):
	pass



############################################################
### \description Gets the level render target.
###
### \note This function fetches the rendering root's
###       target value.
###
func get_target() -> LevelRenderTarget:
	if is_renderer_root():
		return target
	
	if target == null:
		target = get_parent().get_target()
	
	return target

############################################################
### \description Gets the render target rectangle.
###
### \note This function fetches the rendering root's
###       target rectangle.
###
func get_target_rect() -> Rect2:
	if is_renderer_root():
		return target_rectangle
	
	if target_rectangle.size == Vector2():
		target_rectangle = get_parent().get_target_rect()
	
	return target_rectangle
