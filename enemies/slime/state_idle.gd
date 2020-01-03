extends FSM_State



############################################################
### \description Called when the player is sighted.
###
### \note This callback is connected as oneshot.
###
func _on_player_sighted(p):
	controller.state = "chase"
