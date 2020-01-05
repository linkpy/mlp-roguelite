### \description TileMap input of the convolution algo.
###
class_name ConvolutionTileMapInput
extends Convolution.CInput


### \description TileMap used.
var map: TileMap



###################################################### _init
func _init(tm: TileMap) -> void:
	map = tm



################################################## get_value
func get_value(position: Vector2) -> int:
	return map.get_cellv(position)
