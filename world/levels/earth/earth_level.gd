extends Level



func _pre_ready():
	randomize()
	var stime = OS.get_ticks_usec()
	
	var room_pools = RoomRegistery.make_earth_pool()
	var generator = LinearLevelGenerator.new(room_pools)
	var render_target = LevelRenderTarget.new(
		self,
		$map, $map_bg,
		null, null,
		Vector2(1, 1), Vector2(1, 1)
	)
	var builder = LevelBuilder.new(
		render_target, Constants.CellSize
	)
	
	generator.generate(6, 6)
	
	var erooms = generator.get_ending_rooms()
	erooms[randi() % erooms.size()].area_transition = true
	
	builder.render_rooms(generator.rooms)
	rooms = generator.rooms
	
	var spawn = get_tree().get_nodes_in_group("player-spawn")
	if spawn.size() != 0:
		$player.position = spawn[0].position

	var etime = OS.get_ticks_usec()
	print(
		"Total time used to generate the level : ",
		etime - stime, "us"
	)
