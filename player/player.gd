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



############################################################
### \description Called when the player receives damages.
###
func _on_damaged(origin, amnt):
	fsm.state = "hurt"
	
	sprite.flip_h = origin.position.x < position.x


func _input(ev):
	if not Constants.LevelGenerationDebug:
		return
	
	if ev is InputEventKey and ev.pressed and ev.scancode == KEY_F5:
		get_tree().reload_current_scene()
