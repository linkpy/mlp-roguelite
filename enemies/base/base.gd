extends "res://scripts/physics/base_kinematic.gd"



### \description Player detection range.
export var player_detect_range: float = 10

### \description Player detection area
onready var player_detection = $player_detection



### \description Emitted when the player is in sight.
signal player_sighted(p)



############################################################
### \description Set the player's detection
func set_player_detection_radius(r: float) -> void:
	$player_detection/shape.shape.radius = r



############################################################
### \description Called when a body enters the player 
###              detection area.
###
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("player_sighted", body)
