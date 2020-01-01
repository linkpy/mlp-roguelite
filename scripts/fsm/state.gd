class_name FSM_State
extends Node


### \description Object using the FSM
var object = null
### \description FSM controller.
var controller = null



############################################################
### \description Enters the state.
###
### This function is called when the state is entered.
###
### \param data : Additional data for the state.
###
func enter(data) -> void:
	pass

############################################################
### \description Exits the state.
###
### This function is called when the state is exited.
###
func exit():
	pass
