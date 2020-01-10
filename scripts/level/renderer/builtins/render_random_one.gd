### \descrtion Level renderer which renders only one of 
###            its children, selected randomely.
###
class_name LevelRenderNode_RandomOne
extends LevelRenderNode_BasicRenderer



##################################################### render
func render(ri: RoomInstance):
	if get_child_count() == 0:
		return
	
	var children = get_children()
	var selected = children[randi() % children.size()]
	
	_render_child(ri, selected, false)
