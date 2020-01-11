### \description Renderer node, rendering only if the room
###              has backtracking
###
### This node disable its children LevelRendererNode if the
### room doesn't have backtracking
###
class_name LevelRenderNode_IfBacktracking
extends LevelRenderNode_BasicRenderer



### \description If true, renders only when the room has
###              room doesn't have backtracking
export var render_if_not_backtracking: bool = false



##################################################### render
func render(ri: RoomInstance):
	var backtracking = ri.backtracking
	var cond = (
		   (render_if_not_backtracking and not backtracking)
		or (not render_if_not_backtracking and backtracking)
	)
	
	if cond:
		.render(ri)
