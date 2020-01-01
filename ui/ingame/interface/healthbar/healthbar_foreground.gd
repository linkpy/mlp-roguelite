extends Control


### \description Texture to use
export var texture: Texture
### \description Region of the texture to use.
export var sub_rectangle: Rect2 = Rect2(17, 5, 104, 4)



###################################################### _draw
func _draw() -> void:
	# draw the left part of the health bar
	if rect_size.x >= 1:
		var src_rect = sub_rectangle
		src_rect.size.x = 1
		
		draw_texture_rect_region(
			texture, 
			Rect2(0, 0, 1, 4),
			src_rect
		)
	
	# draw the right part of the health bar
	if rect_size.x >= 2:
		var src_rect = sub_rectangle
		src_rect.position.x += src_rect.size.x - 1
		src_rect.size.x = 1
		
		draw_texture_rect_region(
			texture,
			Rect2(rect_size.x-1, 0, 1, 4),
			src_rect
		)
	
	# draw the center of the health bar
	if rect_size.x >= 3:
		var src_rect = sub_rectangle
		src_rect.position.x += 1
		src_rect.size.x -= 2
		
		draw_texture_rect_region(
			texture,
			Rect2(1, 0, rect_size.x-2, 4),
			src_rect
		)



############################################################
### \description Callback used with the resized even of the
###              control.
###
func _on_resized():
	update()
