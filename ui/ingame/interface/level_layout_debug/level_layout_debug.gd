extends Control


onready var level = get_node("../../..")


func _draw():
	if not Constants.LevelGenerationDebug:
		return
	
	var level_rect = get_level_rect()
	
	draw_set_transform(
		rect_size/2 - level_rect.size/2,
		0, Vector2(8, 8)
	)
	
	for room in level.rooms:
		draw_room(room)


func draw_room(r: RoomInstance):
	var c 
	
	if r.is_first_room():
		c = Color(0, 1, 1, 0.25)
	elif r.is_end_room():
		c = Color(1, 1, 0, 0.25)
	elif r.is_branching():
		c = Color(0, 0, 0, 0.25)
	else:
		c = Color(1, 0, 1, 0.25)
	
	draw_rect(
		r.get_rectangle(),
		c,
		true
	)
	
	draw_rect(
		r.get_rectangle(),
		Color.magenta,
		false
	)

func get_level_rect():
	var min_p = Vector2(INF, INF)
	var max_p = Vector2(-INF, -INF)
	
	for r in level.rooms:
		var rr = r.get_rectangle()
		
		if rr.position.x < min_p.x:
			min_p.x = rr.position.x
		if rr.position.y < min_p.y:
			min_p.y = rr.position.y
		if rr.end.x > max_p.x:
			max_p.x = rr.end.x
		if rr.end.y > max_p.y:
			max_p.y = rr.end.y
	
	return Rect2(
		min_p, max_p - min_p
	)
