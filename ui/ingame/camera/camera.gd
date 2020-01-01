extends Camera2D


const PointClass = preload("./focus_point.gd")
const RectClass = preload("./focus_rect.gd")


export var margin: float = 32 # px
export var minimum_zoom: float = 1
export var motion_factor: float = 0.04
export var zoom_factor: float = 0.075

export var player_path: NodePath

onready var player: Node2D = get_node(player_path)

var focus_objects: Array = []



##################################################### _ready
func _ready() -> void:
	focus_objects = get_tree().get_nodes_in_group("camera-focus")



################################################### _process
func _process(dt: float) -> void:
	var close_objs = get_close_focus_objects()
	var target_rect = get_enclosing_rect(close_objs)
	
	var factor = compute_zoom_factor(target_rect)
	
	position = position.linear_interpolate(
		target_rect.position + target_rect.size/2,
		motion_factor
	)
	
	zoom = zoom.linear_interpolate(
		Vector2(factor, factor), 
		zoom_factor
	)



############################################################
### \description Gets the focus object close enough to the
###              player to be took into account.
###
func get_close_focus_objects() -> Array:
	var result = []
	var ppos = player.global_position
	
	for fo in focus_objects:
		if fo.distance < 0:
			result.push_back(fo)
		elif ppos.distance_to(fo.global_position) < fo.get_distance():
			result.push_back(fo)
	
	return result

############################################################
### \description Computes the rectangle enclosing all of the
###              given focus objects.
###
func get_enclosing_rect(objs) -> Rect2:
	var r = Rect2()
	r.position = get_minimum_position(objs)
	r.end = get_maximum_position(objs)
	return r

############################################################
### \description Gets the minimum X and Y coordinate from 
###              the given focus objects.
###
func get_minimum_position(objs) -> Vector2:
	var p = Vector2(INF, INF)
	
	for obj in objs:
		if obj is PointClass:
			var gp = obj.global_position
			
			p.x = min(p.x, gp.x)
			p.y = min(p.y, gp.y)
		
		if obj is RectClass:
			var r = obj.get_rectangle()
			
			p.x = min(p.x, r.position.x)
			p.y = min(p.y, r.position.y)
	
	return p

############################################################
### \description Gets the maximum X and Y coordinate from 
###              the given focus objects.
###
func get_maximum_position(objs) -> Vector2:
	var p = Vector2(-INF, -INF)
	
	for obj in objs:
		if obj is PointClass:
			var gp = obj.global_position
			
			p.x = max(p.x, gp.x)
			p.y = max(p.y, gp.y)
		
		if obj is RectClass:
			var r = obj.get_rectangle()
			
			p.x = max(p.x, r.end.x)
			p.y = max(p.y, r.end.y)
	
	return p

############################################################
### \description Computes the camera's zoom factor based
###              on the target rectangle.
###
func compute_zoom_factor(target_rect: Rect2) -> float:
	var vp_size = Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height")
	)
	var tr_size = target_rect.size + Vector2(margin, margin) * 2
	
	var f = minimum_zoom
	
	if tr_size.x > vp_size.x * f:
		f = tr_size.x / vp_size.x
	
	if tr_size.y > vp_size.y * f:
		f = tr_size.y / vp_size.y
	
	return f
