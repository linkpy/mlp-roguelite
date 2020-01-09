### \description Level rendering system's target.
###
### Contains all of the informations for the level renderer.
###
class_name LevelRenderTarget
extends Reference



### \description Tile layers.
enum TileLayer {
	### \description Foreground (collision) layer.
	Foreground,
	### \description Background layer.
	Background,
}

### \description Object layers
enum ObjectLayer {
	### \description Foreground (player, enemies) layer.
	Foreground,
	### \description Near background layer.
	NearBackground,
	### \description Far background layer.
	FarBackground
}



### \description Root node of the level.
var level: Node2D
### \description Foreground tilemap.
var foreground_tilemap: TileMap
### \description Background tilemap.
var background_tilemap: TileMap
### \description Near background object layer.
var near_background_layer: CanvasLayer
### \description Far background object layer.
var far_background_layer: CanvasLayer
### \description Near background object's position scaling.
var near_background_scale: Vector2
### \description Far background object's position scaling.
var far_background_scale: Vector2


###################################################### _init
func _init(
	lvl: Node2D,
	fgtm: TileMap, bgtm: TileMap,
	nbg: CanvasLayer,
	fbg: CanvasLayer,
	nbgs: Vector2,
	fbgs: Vector2
) -> void:
	level = lvl
	foreground_tilemap = fgtm
	background_tilemap = bgtm
	near_background_layer = nbg
	far_background_layer = fbg
	near_background_scale = nbgs
	far_background_scale = fbgs



############################################################
### \description Gets the size of a tile.
###
func get_tile_size() -> Vector2:
	return foreground_tilemap.cell_size



############################################################
### \description Gets the tilemap associated with the given
###              tile layer.
###
func get_tile_layer(tl: int) -> TileMap:
	match tl:
		TileLayer.Foreground:
			return foreground_tilemap
		TileLayer.Background:
			return background_tilemap
		_:
			printerr("Invalid tile layer ID.")
			assert(false)
			return null

############################################################
### \description Gets the node associated with the given 
###              object layer.
###
func get_object_layer(ol: int) -> Node:
	match ol:
		ObjectLayer.Foreground:
			return level
		ObjectLayer.NearBackground:
			return near_background_layer
		ObjectLayer.FarBackground:
			return far_background_layer
		_:
			printerr("Invalid object layer ID.")
			assert(false)
			return null



func get_object_new_position(ol: int, p: Vector2) -> Vector2:
	match ol:
		ObjectLayer.Foreground:
			return p
		ObjectLayer.NearBackground:
			return p * near_background_scale
		ObjectLayer.FarBackground:
			return p * far_background_scale
		_:
			printerr("Invalid object layer ID.")
			assert(false)
			return Vector2()
