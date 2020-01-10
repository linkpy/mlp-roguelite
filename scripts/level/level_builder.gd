### \description Level builder.
###
### Uses a render target and level renderers to generate
### the level.
###
class_name LevelBuilder
extends Reference



### \description Render target.
var render_target: LevelRenderTarget
### \description Size (in tiles) of a layout cell.
var layout_cell_size: Vector2



###################################################### _init
func _init(rt: LevelRenderTarget, lcs: Vector2) -> void:
	render_target = rt
	layout_cell_size = lcs



############################################################
### \description Renders the given rooms.
###
func render_rooms(rooms: Array):
	for room in rooms:
		_render_room(room)
	
	var rect = render_target.foreground_tilemap.get_used_rect()
	render_target.foreground_tilemap.update_bitmask_region(
		rect.position, rect.end
	)
	
	rect = render_target.background_tilemap.get_used_rect()
	render_target.background_tilemap.update_bitmask_region(
		rect.position, rect.end
	)

############################################################
### \description Renders the given room.
###
func _render_room(room: RoomInstance):
	var renderer: LevelRenderNode
	
	renderer = room.definition.render_template.instance()
	renderer.target = render_target
	renderer.target_rectangle = Rect2(
		room.position * layout_cell_size,
		room.definition.size * layout_cell_size
	)
	
	renderer.render(room)
	
	renderer.free()
