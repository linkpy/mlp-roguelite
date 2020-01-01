extends FSM_State

const Attack = preload("res://player/attacks/player_attack1.tscn")



###################################################### enter
func enter(data) -> void:
	# start the attack animation of the player
	object.animation.play("attack1")
	
	# create the attack instance
	var a = Attack.instance()
	a.position = object.position
	
	# flip it to face the player's direction
	if object.sprite.flip_h:
		a.scale.x = -1
	
	# add the object in the scene tree
	object.get_parent().add_child(a)
