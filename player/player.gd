### \description Master script of the player.
###
### \note The player is mostly controlled throught its FSM 
###       controller.
###
extends "res://scripts/entity/base_entity.gd"



### \description FSM of the player
onready var fsm = $fsm
### \description Sprite of the player
onready var sprite = $sprite
### \description Animation controller of the player.
onready var animation = $animation



############################################################
### \description Get the movement input vector.
###
### Returns a vector based on the state of the actions
### `left`, `right`, `up`, `down`.
###
### \return A vector representing the state of the movement 
### input.
###
func get_movement_input_vector() -> Vector2:
	var m = Vector2()
	
	if Input.is_action_pressed("left"):
		m.x -= 1
	if Input.is_action_pressed("right"):
		m.x += 1
	if Input.is_action_pressed("up"):
		m.y -= 1
	if Input.is_action_pressed("down"):
		m.y += 1
	
	return m
