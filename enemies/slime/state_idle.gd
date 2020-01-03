extends FSM_State



########################################### _physics_process
func _physics_process(dt: float) -> void:
	object.move(dt)



############################################################
### \description Called when the player is sighted.
###
### \note This callback is connected as oneshot.
###
func _on_player_sighted(p):
	controller.state = "chase"
