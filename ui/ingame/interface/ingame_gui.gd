extends Control


### \description Path to the player node
export var player_path: NodePath

### \description Player instance
onready var player = get_node(player_path)
### \description Health bar instance
onready var healthbar = $healthbar



##################################################### _ready
func _ready():
	healthbar.set_value(50, 100)
