tool
extends StaticBody2D



export var half_width: int = 12 setget set_half_width
export var texture: Texture
export var h_margin: int = 2



func _draw() -> void:
	var tsize = texture.get_size()
	
	draw_texture_rect_region(
		texture,
		Rect2(
			-half_width, -tsize.y/2,
			h_margin, tsize.y
		),
		Rect2(
			0, 0,
			h_margin, tsize.y
		)
	)
	
	draw_texture_rect_region(
		texture,
		Rect2(
			-half_width + h_margin, -tsize.y/2,
			half_width*2 - h_margin*2, tsize.y
		),
		Rect2(
			h_margin, 0,
			tsize.y - h_margin*2, tsize.y
		)
	)
	
	draw_texture_rect_region(
		texture,
		Rect2(
			half_width - h_margin, -tsize.y/2,
			h_margin, tsize.y
		),
		Rect2(
			tsize.x - h_margin, 0,
			h_margin, tsize.y
		)
	)



func set_half_width(v: int) -> void:
	half_width = v
	$shape.shape.extents.x = v
	update()
