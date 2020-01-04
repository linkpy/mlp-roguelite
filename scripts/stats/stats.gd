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
### \description Constructor.
###
### Initializes the properties.
###
func _init() -> void:
	max_health = StatsProperty.new(max_health_, 0, 0)
	attack = StatsProperty.new(attack_, 0, 0)
	movement_speed = StatsProperty.new(movement_speed_, 0, 0)
	jump_force = StatsProperty.new(jump_force_, 0, 0)



############################################################
### \description Get the max health's value.
###
func get_max_health() -> float:
	return max_health.value()

############################################################
### \description Get the attack's value.
###
func get_attack() -> float:
	return attack.value()

############################################################
### \description Get the movement speed's value.
###
func get_movement_speed() -> float:
	return movement_speed.value()

############################################################
### \description Get the jump force's value.
###
func get_jump_force() -> float:
	return jump_force.value()
