tool
extends Area2D


export var cell_size: Vector2 = Constants.CellSize setget set_cell_size
export var tile_size: Vector2 = Constants.TileSize setget set_tile_size
export var size: Vector2 = Vector2(2, 2) setget set_size

var instance: RoomInstance



signal visited(rinst)



func _draw():
	if not Engine.editor_hint:
		return
	
	draw_set_transform(
		-$shape.shape.extents, 0, Vector2(1, 1)
	)
	
	for x in range(size.x):
		for y in range(size.y):
			draw_rect(
				Rect2(
					Vector2(x, y) * tile_size * cell_size,
					tile_size * cell_size
				), Color.magenta, false, 4
			)




func update_shape():
	var s: RectangleShape2D = $shape.shape
	
	s.extents = (
		  size
		* tile_size
		* cell_size
		/ 2
	)
	
	position = (
		  size
		* tile_size
		* cell_size
		/ 2
	)
	
	if Engine.editor_hint:
		update()



func set_cell_size(v):
	cell_size = v
	update_shape()

func set_tile_size(v):
	tile_size = v
	update_shape()

func set_size(v):
	size = v
	update_shape()



func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("visited", instance)
