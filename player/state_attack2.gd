extends FSM_State



### \description Player attack scene.
const Attack = preload("res://player/attacks/player_attack2.tscn")



### \description True if the attack should be chained with
### the next one.
var continue_attack: bool = false



###################################################### enter
func enter(_data) -> void:
	_configure_state()
	_configure_player()
	_spawn_attack()



################################################### _process
func _process(_dt: float) -> void:
	if object.sprite.frame >= 3:
		if Input.is_action_pressed("attack"):
			continue_attack = true



############################################################
### \description Called when the player's animation player
###              finished an animation.
###
func _on_animation_finished(anim: String):
	if anim == "attack2":
		if continue_attack:
			controller.state = "normal"
		else:
			controller.state = "normal"



############################################################
### \description Configure the state.
###
func _configure_state() -> void:
	continue_attack = false

############################################################
### \description Configure the player
###
func _configure_player() -> void:
	# start the attack animation of the player
	object.animation.play("attack2")

############################################################
### \description Spawn the attack instance.
###
func _spawn_attack() -> void:
	# create the attack instance
	var a = Attack.instance()
	a.player = object
	a.position = object.position
	
	# flip it to face the player's direction
	if object.sprite.flip_h:
		a.scale.x = -1
	
	# add the object in the scene tree
	object.get_parent().add_child(a)
