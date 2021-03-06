### \description Camera focus point.
###
### This object is a focus object used by the camera.
### See FocusBasedCamera for more information on how the 
### camera system works.
###
tool
class_name CameraFocusPoint
extends Position2D



### \description Enables or not the focus point.
export var enabled: bool = true
### \description Distance at which the point is used.
export var distance: float = 10 setget set_distance # m



###################################################### _draw
func _draw():
	if (Engine.editor_hint or Constants.CameraDebug) and distance > 0:
		draw_arc(
			Vector2(),
			get_distance(),
			0, 2 * PI, 32,
			Color(1, 0, 1, 0.3)
		)



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
