### \description Renderer node, rendering only if a given
###              door is connected or not.
###
### This node disable its children LevelRendererNode if the
### given door is (not) connected.
###
class_name LevelRenderNode_IfDoorConnected
extends LevelRenderNode



### \description Index of the door to check.
export var door_index: int
### \description If true, renders only when the door isn't 
###              connected.
export var render_if_not_connected: bool = false



##################################################### render
func render(ri: RoomInstance):
	var connected = ri.has_connection(door_index)
	var should_render = (
		   (render_if_not_connected and not connected)
		or (not render_if_not_connected and connected)
	)
	
	if should_render:
		.render(ri)
