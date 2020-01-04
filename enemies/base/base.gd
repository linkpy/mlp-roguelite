### \description Base class for all enemies.
###
### It implements a player detecting range. When the player
### is detected, the signal `player_sighted` is emitted.
###
### \note The signal is emitted each time the player enters
###       the detection area.
###
### \note Due to the bug fixed in the commit
###       ff3acda7391c56ab118f715dadb3444b777813d9, the
###       player detection range must be set from the 
###       inherited class using set_player_detection_radius.
### 
extends "res://scripts/entity/base_entity.gd"



### \description Maximum width of the health bar.
const HealthBarMaxWidth = 48
const HealthBarHeight = 5



### \description Player detection range.
export var player_detect_range: float = 10
### \description Y offset of the enemy's health bar.
export var health_bar_offset: float = 16

### \description Player detection area
onready var player_detection = $player_detection



### \description Emitted when the player is in sight.
signal player_sighted(p)



###################################################### _draw
func _draw() -> void:
	_draw_health_bar()



############################################################
### \description Set the player's detection
###
func set_player_detection_radius(r: float) -> void:
	$player_detection/shape.shape.radius = r



############################################################
### \description Called when a body enters the player 
###              detection area.
###
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("player_sighted", body)

func _on_health_changed(_origin, _amnt):
	update()




func _draw_health_bar():
	if health == stats.get_max_health():
		return
	
	var hp_per_pixel = 1
	var max_hp = stats.get_max_health()
	
	while ceil(max_hp / hp_per_pixel) > HealthBarMaxWidth:
		hp_per_pixel += 1
	
	
	var full_width = ceil(max_hp / hp_per_pixel) + 2
	var hp_width = ceil(health / hp_per_pixel)
	
	draw_rect(
		Rect2(
			-full_width/2,
			health_bar_offset,
			full_width,
			HealthBarHeight
		), 
		Color.black
	)
	
	draw_rect(
		Rect2(
			-full_width/2 + 1,
			health_bar_offset + 1,
			hp_width,
			HealthBarHeight - 2
		),
		Color.red
	)



