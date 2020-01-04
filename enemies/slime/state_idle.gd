### \description Idle state of the slime.
###
### \note The state is entered as the initial state of the 
###       FSM.
###
### \note The state is exited when the player is sighted
###       (`player_sighted` signal emitted).
###
extends FSM_State



########################################### _physics_process
func _physics_process(dt: float) -> void:
	object.move(dt)



############################################################
### \description Called when the player is sighted.
###
### \note This callback is connected as oneshot.
###
func _on_player_sighted(_p):
	controller.state = "chase"
