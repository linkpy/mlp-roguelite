### \description Renderer node, rendering only if the room
###              doesn't have any following room.
###
### This node disable its children LevelRendererNode if the
### room doesn't have any room connected to its exit doors.
###
class_name LevelRenderNode_IfEndRoom
extends LevelRenderNode_BasicRenderer



### \description If true, renders only when the room has
###              rooms connected to any of its exit doors.
export var render_if_not_end: bool = false



##################################################### render
func render(ri: RoomInstance):
	var end = ri.is_end_room()
	var cond = (
		   (render_if_not_end and not end)
		or (not render_if_not_end and end)
	)
	
	if cond:
		.render(ri)
