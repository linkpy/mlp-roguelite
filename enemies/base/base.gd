extends "res://scripts/physics/base_kinematic.gd"


### \description Player detectin radius.
export var player_detection_radius: float = 10

### \description Player detection area
onready var player_detection = $player_detection



### \description Emitted when the player is in sight.
signal player_sighted(p)



##################################################### _ready
func _ready() -> void:
	$player_detection/shape.shape.radius = player_detection_radius



############################################################
### \description Called when a body enters the player 
###              detection area.
###
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("player_sighted", body)
