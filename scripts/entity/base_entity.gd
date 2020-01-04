### \description Base class for all damagable entities.
###
extends "res://scripts/entity/base_kinematic.gd"



### \description Stats resource.
export(Resource) var stats

### \description Health of the entity.
onready var health = stats.get_max_health()
