### \description Renderer node, rendering only if the room
###              doesn't have any previous room.
###
### This node disable its children LevelRendererNode if the
### room doesn't have any room connected to its entry doors.
###
class_name LevelRenderNode_IfFirstRoom
extends LevelRenderNode_BasicRenderer



### \description If true, renders only when the room has
###              rooms connected to any of its entry doors.
export var render_if_not_first: bool = false



##################################################### render
func render(ri: RoomInstance):
	var first = ri.is_first_room()
	var cond = (
		   (render_if_not_first and not first)
		or (not render_if_not_first and first)
	)
	
	if cond:
		.render(ri)
