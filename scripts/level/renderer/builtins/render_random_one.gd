### \descrtion Level renderer which renders only one of 
###            its children, selected randomely.
###
class_name LevelRenderNode_RandomOne
extends LevelRenderNode_BasicRenderer



### \description If true, the node may render nothing
export var may_render_nothing: bool = false



##################################################### render
func render(ri: RoomInstance):
	if get_child_count() == 0:
		return
	
	var children = get_children()
	var idx = (
		  randi()
		% (children.size() + (1 if may_render_nothing else 0))
	)
	
	if idx >= children.size():
		return
	
	var selected = children[idx]
	
	_render_child(ri, selected, false)
