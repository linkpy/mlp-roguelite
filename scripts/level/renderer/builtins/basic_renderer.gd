### \description Basic level renderer node.
###
### This renderer node renders every of its children 
### following some rules :
### - TileMaps are blits to the render target
### - CanvasLayers's content are moved to the render target
### - Every other nodes are moved too.
###
### If the tilemap contains `_bg`, its content will be 
### blits to the background tile layer, otherwise its
### content will be blits to the foreground tile layer.
###
### If the tilemap contains `_override`, its empty cells
### will override the target tile layer, otherwise empty
### cells wont override the cells of the target tile layer.
###
### If the canvaslayer is called `near_bg`, its content
### will be moved to the near background object layer.
### If the canvaslayer is called `far_bg`, its content
### will be moved to the far background object layer.
### Otherwise, the canvaslayer's content will be moved
### to the foreground object layer.
###
class_name LevelRenderNode_BasicRenderer
extends LevelRenderNode



#################################################### _render
func _render(ri: RoomInstance):
	for child in get_children():
		_render_child(ri, child, true)

############################################################
### \description Renders the given node.
###
func _render_child(ri: RoomInstance, c: Node, ignore_rn: bool = true):
	# LevelRenderNode are ignored
	if c is LevelRenderNode:
		if not ignore_rn:
			c.render(ri)
		
		return
	
	if c is TileMap:
		_render_tilemap(c)
	elif c is CanvasLayer:
		_render_layer(c)
	else:
		move_object(
			LevelRenderTarget.ObjectLayer.Foreground,
			c.name
		)

############################################################
### \description Renders the given tilemap.
###
func _render_tilemap(tm: TileMap):
	var layer = LevelRenderTarget.TileLayer.Foreground
	var override = false
	
	if tm.name.find("_bg") != -1:
		layer = LevelRenderTarget.TileLayer.Background
	if tm.name.find("_override") != -1:
		override = true
	
	blits_tiles(
		layer,
		tm.name,
		override
	)

############################################################
### \description Renders the given canvas layer.
###
func _render_layer(cl: CanvasLayer):
	var l = LevelRenderTarget.ObjectLayer.Foreground
	
	if cl.name == "near_bg":
		l = LevelRenderTarget.ObjectLayer.NearBackground
	
	if cl.name == "far_bg":
		l = LevelRenderTarget.ObjectLayer.FarBackground
	
	for child in cl.get_children():
		move_object(
			l,
			cl.name + "/" + child.name
		)
