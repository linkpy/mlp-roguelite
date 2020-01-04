### \description Attack recovery state of the slime.
###
### \note The state is entered when the slime touches the 
###       floor while in the 'attack_active' state.
###
### \note The state is exited when the animation 
###       'attack_recovery' is finished. The animation 
###       player switches the state throught a function call
###       track.
###
extends FSM_State



###################################################### enter
func enter(data) -> void:
	object.animation.play("attack_recovery")
