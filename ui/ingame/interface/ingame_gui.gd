### \description Ingame GUI controller.
###
### This class manage the ingame GUI.
###
extends Control



### \description Path to the player node
export var player_path: NodePath

### \description Player instance
onready var player = get_node(player_path)
### \description Health bar instance
onready var healthbar = $healthbar



##################################################### _ready
func _ready():
	player.connect("damaged", self, "_update_health_bar")
	player.connect("healed", self, "_update_health_bar")
	
	call_deferred("_update_health_bar", null, null)



############################################################
### \description Update the health bar.
###
func _update_health_bar(_origin, _amnt):
	healthbar.set_value(
		player.health,
		player.stats.get_max_health()
	)
