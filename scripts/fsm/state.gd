### \description A state used in a FSM controller.
###
### The state has two variables : the controlled object
### (the parent of the FSM controller) and the FSM 
### controller.
###
### The `enter` function is called when the state is entered
### and the `exit` function is called when the state is 
### exited.
###
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
func enter(_data) -> void:
	pass

############################################################
### \description Exits the state.
###
### This function is called when the state is exited.
###
func exit():
	pass



############################################################
### \description Retruns true if the state is the current
###              active state.
###
func is_active() -> bool:
	return controller.current_state == self
