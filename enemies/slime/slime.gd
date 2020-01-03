extends "res://enemies/base/base.gd"


### \description Movement speed of the slime.
export var movement_speed: float = 3 # m/s
### \description Velocity impulse when the slime attacks.
export var attack_impulse: float = 10
### \description Movement speed when the slime is attacking.
export var attack_speed: float = 9 # m/s

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



### \description Called when the player is sighted.
###
### \note This is connected as oneshot.
###
func _on_player_sighted(p):
	player = p
