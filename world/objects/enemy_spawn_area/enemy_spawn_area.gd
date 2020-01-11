### \description Enemy spawn area.
###
tool
extends VisibilityNotifier2D



### \description Half size of the area.
export var extents: Vector2 = Vector2(12,12) setget set_extents
### \description List of enemies to spawn with their count.
export var enemies: Dictionary = {}

### \description Pools of enemies.
var pool: EnemyPools



##################################################### _ready
func _ready() -> void:
	if not Engine.editor_hint:
		pool = get_parent().enemy_pool



############################################################
### \description Sets the half size of the area.
###
func set_extents(v):
	extents = v
	
	rect.position = -v
	rect.size = 2*v



############################################################
### \description Called when the area enters the screen.
###
### \note Connected as oneshot.
###
func _on_screen_entered():
	for kind in enemies.keys():
		if kind.find("_") != -1:
			kind = kind.substr(0, kind.find("_"))
		
		var psc = pool.get_random_enemy(kind)
		
		if psc == null:
			continue
		
		for i in range(enemies[kind]):
			var pos = (
				  position 
				+ Vector2(
					rand_range(-extents.x, extents.x),
					rand_range(-extents.y, extents.y)
				  )
			)
			
			var inst = psc.instance()
			inst.position = pos
			get_parent().add_child(inst)
