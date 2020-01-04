### \description Damange indicator.
###
extends Node2D



### \description Value to show.
export var value: float = 1234 setget set_value
### \description Text offset.
export var offset: Vector2 = Vector2() setget set_offset
### \description Random spawn offset.
export var random_offset: Vector2 = Vector2(16,16)
### \description Font to use to draw the value.
export(Font) var font



##################################################### _ready
func _ready() -> void:
	position += Vector2(
		rand_range(-random_offset.x/2, random_offset.x/2),
		rand_range(-random_offset.y/2, random_offset.y/2)
	)

###################################################### _draw
func _draw() -> void:
	var string = str(ceil(value))
	var size = font.get_string_size(string)
	
	draw_string(
		font, 
		offset - Vector2(size.x/2, -size.y/2), 
		string
	)



############################################################
### \description Set the value of the indicator.
###
func set_value(v: float) -> void:
	value = v
	$animation.play("animation")
	update()

############################################################
### \description Set the text drawing offset.
###
func set_offset(v: Vector2) -> void:
	offset = v
	update()
