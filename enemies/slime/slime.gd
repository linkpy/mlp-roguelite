### \description Master script for the slime enemy
###
### \note The slime is mostly controlled throught its
###       FSM controller.
###
extends "res://enemies/base/base.gd"



### \description State machine.
onready var fsm = $fsm
### \description Sprite of the slime.
onready var sprite = $sprite
### \description Animation controller.
onready var animation = $animation

### \description Sighted player.
var player = null



##################################################### _ready
func _ready() -> void:
	set_player_detection_radius(player_detect_range)



############################################################
### \description Called when the player is sighted.
###
### \note This is connected as oneshot.
###
func _on_player_sighted(p):
	player = p

############################################################
### \description Called when the slime is killed.
###
### \note This is connected as oneshot.
###
func _on_killed(origin):
	queue_free()
