### \description Resource that holds all of the common
###              properties for an entity's stats.
###
class_name Stats
extends Resource



### \description Base value of the entity's max health.
export(float) var max_health_
### \description Base value of the entity's attack.
export(float) var attack_
### \description Base value of the entity's movement speed.
export(float) var movement_speed_
### \description Base value for the entity's jump force.
export(float) var jump_force_

### \description Max health property.
var max_health: StatsProperty
### \description Attack property.
var attack: StatsProperty
### \description Movement speed property.
var movement_speed: StatsProperty
### \description Jump force property.
var jump_force: StatsProperty



############################################################
### \description Initializes the stats object.
###
### Initializes the properties.
###
func initialize() -> void:
	max_health = StatsProperty.new(max_health_, 0, 0)
	attack = StatsProperty.new(attack_, 0, 0)
	movement_speed = StatsProperty.new(movement_speed_, 0, 0)
	jump_force = StatsProperty.new(jump_force_, 0, 0)

############################################################
### \description Return true if the stats object is ready
###              to be used.
###
func is_initiliazed() -> bool:
	return max_health != null



############################################################
### \description Get the max health's value.
###
func get_max_health() -> float:
	if not is_initiliazed():	initialize()
	return max_health.value()

############################################################
### \description Get the attack's value.
###
func get_attack() -> float:
	if not is_initiliazed():	initialize()
	return attack.value()

############################################################
### \description Get the movement speed's value.
###
func get_movement_speed() -> float:
	if not is_initiliazed():	initialize()
	return movement_speed.value()

############################################################
### \description Get the jump force's value.
###
func get_jump_force() -> float:
	if not is_initiliazed():	initialize()
	return jump_force.value()
