### \description Finite State Machine controller.
###
### The FSM controller implements state switching, state
### processes control and an initial state entered in the
### `_ready` callback.
###
### When the current state is switched, the current state's
### `exit` method is called and its processes are disabled, 
### the current state is switched internaly, the new state's
### `enter` method is called and its processes are enabled.
###
### \note It is possible to switch from/to a `null` state
###       by using an empty string (`""`) as the state name.
###
class_name FSM
extends Node



### \description Initial state of the FSM.
export var initial_state: String = ""



### \description Name of the current state
var state: String setget set_state, get_state
### \description Current state.
var current_state = null



##################################################### _ready
func _ready() -> void:
	initialize_states()
	
	if initial_state != "":
		set_state(initial_state)



############################################################
### \description Initializes the children states.
###
func initialize_states() -> void:
	for c in get_children():
		c.object = get_parent()
		c.controller = self
		
		_set_state_processes(c, false)



############################################################
### \description Define the current state.
###
### Switches the current state with optional additional
### data.
###
### \param new_state : The name of the new state.
### \param data : Additional data to pass to the new state.
###
func switch_state(new_state: String, data = null) -> void:
	# notify the current state it will exit
	_exit_state(current_state)
	
	# define the new state
	if new_state != "":
		assert(has_node(new_state))
		current_state = get_node(new_state)
	else:
		current_state = null
	
	# notify the new state it will enter
	_enter_state(current_state, data)

############################################################
### \description Define the current state.
###
### Switches the current state without passing any 
### additional data.
### 
### \param new_state : The name of the new state.
###
func set_state(new_state: String) -> void:
	switch_state(new_state)

############################################################
### \description Get the current state's name.
###
### \return The name of the new state.
###
func get_state() -> String:
	if current_state == null:
		return ""
	
	return current_state.name



############################################################
### \description Notifies and configures the state when it
###              enters.
###
### \param state : The state to notify and to configure.
### \param data : Additional data to pass to the state.
###
func _enter_state(state_n, data) -> void:
	if state_n == null:
		return
	
	_set_state_processes(state_n, true)
	state_n.enter(data)

############################################################
### \description Notifies and configures the state when it
###              exits.
###
### \param state : The state to notify and configure.
###
func _exit_state(state_n) -> void:
	if state_n == null:
		return
	
	state_n.exit()
	_set_state_processes(state_n, false)

############################################################
### \description Enables or disables the node's processes.
###
### \param state : The target.
### \param enabled : True to enables the processes, false 
###        otherwise.
func _set_state_processes(state_n: Node, enabled: bool) -> void:
	state_n.set_process(enabled)
	state_n.set_process_input(enabled)
	state_n.set_physics_process(enabled)
