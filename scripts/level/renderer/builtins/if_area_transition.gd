### \description Renderer node, rendering only if the room
###              is an area transition room.
###
### This node disable its children LevelRendererNode if the
### room isn't an area transition
###
class_name LevelRenderNode_IfAreaTransition
extends LevelRenderNode_BasicRenderer



### \description If true, renders only when the room has
###              rooms isn't a transition
export var render_if_not_transition: bool = false



##################################################### render
func render(ri: RoomInstance):
	var transition = ri.area_transition
	var cond = (
		   (render_if_not_transition and not transition)
		or (not render_if_not_transition and transition)
	)
	
	if cond:
		.render(ri)
