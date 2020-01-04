### \description Base class for all damagable entities.
###
class_name BaseEntity
extends "res://scripts/entity/base_kinematic.gd"



### \description Damage indicator scene.
const DamageIndicator = preload("res://ui/ingame/damage_indicator/damage_indicator.tscn")



### \description Stats resource.
export(Resource) var stats

### \description Health of the entity.
var health



### \description Emitted when the entity is damaged
signal damaged(origin, amnt)
### \description Emitted when the entity is healed
signal healed(origin, amnt)
### \description Emitted when the entity is killed
signal killed(origin)



##################################################### _ready
func _ready():
	stats.initialize()
	health = stats.get_max_health()



############################################################
### \description Returns true if the entity is dead.
###
func is_dead() -> bool:
	return health == 0



############################################################
### \description Applies damages to the entity.
###
### \param origin : entity applying the damages.
### \param amnt : amount of applied damages.
###
func apply_damages(origin, amnt: float) -> void:
	emit_signal("damaged", origin, amnt)
	_spawn_damage_indicator(amnt, Color.red)
	
	health = max(0, health - amnt)
	
	if health == 0:
		emit_signal("killed", origin)

############################################################
### \description Applies healing to the entity.
###
### \param origin : entity applying the heal.
### \param amnt : amount of applied healing.
###
func apply_healing(origin, amnt: float) -> void:
	emit_signal("healed", origin, amnt)
	_spawn_damage_indicator(amnt, Color.green)
	
	health = min(stats.get_maximum_health(), health + amnt)



############################################################
### \description Spawn a damage indicator.
###
func _spawn_damage_indicator(amnt: float, col: Color) -> void:
	var inst = DamageIndicator.instance()
	inst.position = position
	inst.value = amnt
	inst.modulate = col
	
	get_parent().add_child(inst)
