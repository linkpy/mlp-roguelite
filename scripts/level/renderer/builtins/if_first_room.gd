### \description Renderer node, rendering only if the room
###              doesn't have any previous room.
###
### This node disable its children LevelRendererNode if the
### room doesn't have any room connected to its entry doors.
###
class_name LevelRenderNode_IfFirstRoom
extends LevelRenderNode



### \description If true, renders only when the room has
###              rooms connected to any of its entry doors.
export var render_if_not_first: bool = false



##################################################### render
func render(ri: RoomInstance):
	var first = is_first(ri)
	var cond = (
		   (render_if_not_first and not first)
		or (not render_if_not_first and first)
	)
	
	if cond:
		.render(ri)



############################################################
### \description Checks if the room is the first room of the
###              level.
###
func is_first(ri: RoomInstance) -> bool:
	for i in range(ri.connections.size()):
		var def = ri.definition.doors[i]
		var entry = def.direction == RoomDoorDefinition.Direction.Entry
		
		if entry and ri.has_connection(i):
			return false
	
	return true
