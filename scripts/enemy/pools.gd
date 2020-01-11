class_name EnemyPools
extends Reference



var pools: Dictionary



func _init() -> void:
	pools = {}



func has_pool(pool: String) -> bool:
	return pools.has(pool)



func add_enemy(pool: String, e: PackedScene):
	if has_pool(pool):
		pools[pool].push_back(e)
	else:
		pools[pool] = [e]
	
	return self

func add_enemies(pool: String, es: Array):
	for e in es:
		add_enemy(pool, e)
	
	return self

func import_enemies(d: Dictionary):
	for pool in d.keys():
		add_enemies(pool, d[pool])
	
	return self



func get_enemies(pool: String) -> Array:
	if not has_pool(pool):
		return []
	
	return pools[pool]

func get_random_enemy(pool: String) -> PackedScene:
	var l = get_enemies(pool)
	
	if l.size() == 0:
		return null
	
	return l[randi() % l.size()]
