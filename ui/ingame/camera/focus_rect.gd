tool
extends Position2D



export var half_extents: Vector2 = Vector2(8,8) setget set_half_extents
export var distance: float = 10 setget set_distance # m



###################################################### _draw
func _draw() -> void:
	if Engine.editor_hint or Constants.CameraDebug:
		draw_arc(
			Vector2(),
			get_distance(),
			0, 2 * PI, 32,
			Color(1, 0, 1, 0.3)
		)
		
		draw_rect(
			Rect2(
				-half_extents.x, -half_extents.y,
				half_extents.x*2, half_extents.y*2
			), 
			Color(1, 0, 1, 0.4), false,
			1
		)



############################################################
### \description Defines the half extents of the focus 
###              rectangle.
###
### \param v : the new half extents.
###
func set_half_extents(v: Vector2) -> void:
	half_extents = v
	update()

############################################################
### \description Defines the distance at which the focus 
###              object is took into account.
###
### \param v : the new distance.
###
func set_distance(v: float) -> void:
	distance = v
	update()

############################################################
### \description Gets the distance of the point in pixel.
###
func get_distance() -> float:
	return distance * Constants.OneMeter

############################################################
### \description Gets the rectangle of the object.
###
func get_rectangle() -> Rect2:
	return Rect2(
		global_position - half_extents,
		half_extents * 2
	)
