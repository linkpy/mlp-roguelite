extends Control


export var texture: Texture
export var sub_rectangle: Rect2 = Rect2(17, 5, 104, 4)



func _draw() -> void:
	if rect_size.x >= 1:
		var src_rect = sub_rectangle
		src_rect.size.x = 1
		
		draw_texture_rect_region(
			texture, 
			Rect2(0, 0, 1, 4),
			src_rect
		)
	
	if rect_size.x >= 2:
		var src_rect = sub_rectangle
		src_rect.position.x += src_rect.size.x - 1
		src_rect.size.x = 1
		
		draw_texture_rect_region(
			texture,
			Rect2(rect_size.x-1, 0, 1, 4),
			src_rect
		)
	
	if rect_size.x >= 3:
		var src_rect = sub_rectangle
		src_rect.position.x += 1
		src_rect.size.x -= 2
		
		draw_texture_rect_region(
			texture,
			Rect2(1, 0, rect_size.x-2, 4),
			src_rect
		)


func _on_resized():
	update()
