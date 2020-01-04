### \description Base class for all damagable entities.
###
class_name BaseEntity
extends "res://scripts/entity/base_kinematic.gd"



### \description Stats resource.
export(Resource) var stats

### \description Health of the entity.
var health



##################################################### _ready
func _ready():
	stats.initialize()
	health = stats.get_max_health()
