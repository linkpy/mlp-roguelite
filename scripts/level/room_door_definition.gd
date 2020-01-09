### \description Description of a room door.
###
### It represents a pathway between two rooms. A door is 
### described using three parameters :
###  1. Direction : defines if the door is a room entry or
###     a room exit.
###  2. Side : defines on which side of the room the dor is
###     (left, right, top, bottom).
###  3. Position : defines the position (in tiles) of the
###     door.
###
### The position of the door is relative to the room's 
### postion and the side on which the door is :
###  - If the door is on the left or right side, then 
###    position 0 is at the top of the side.
###  - If the door is on the top or bottom side, then 
###    position 0 is at the left of the side.
###
### The diagram shows the position 0 on each side of the 
### room.
###
###    v
###   >+--------+<
###    |        |
###    +--------+
###    ^
###
class_name RoomDoorDefinition
extends Reference



### \description Direction of a door.
enum Direction {
	### \description Entry of a room
	Entry = 0,
	### \description Exit of a room
	Exit = 1
}

### \description Side of the door
enum Side {
	### \description Door on the right side of a room
	Right = 0,
	### \description Door on the bottom side of a room
	Bottom = 1,
	### \description Door on the left side of a room
	Left = 2,
	### \description Door on the top side of a room
	Top = 3
}



############################################################
### \description Reverse the given direction.
### 
static func reverse_direction(d: int) -> int:
	return (d + 1) % 2

############################################################
### \description Reverse the given side.
### 
static func reverse_side(s: int) -> int:
	return (s + 2) % 4

############################################################
### \description Returns the normal of the given side.
###
static func side_normal(s: int) -> Vector2:
	return Vector2(1, 0).rotated(PI/2 * (s % 4)).round()



### \description Direction of the door (entry/exit)
var direction: int
### \description On which side of the room the door is.
var side: int
### \description Position of the door relative to left/top.
var position: int



###################################################### _init
func _init(dir: int, sid: int, pos: int) -> void:
	if dir < Direction.Entry or dir > Direction.Exit:
		printerr("Invalid `Direction` value.")
		assert(false)
		
	if sid < Side.Right or sid > Side.Top:
		printerr("Invalid `Side` value.")
		assert(false)
	
	direction = dir
	side = sid
	position = pos



############################################################
### \description Gets the position of the door in space
###              relative to the given room size.
###
func get_position_in_space(size: Vector2) -> Vector2:
	match side:
		Side.Right:
			return Vector2(size.x-1, position)
		Side.Bottom:
			return Vector2(position, size.y-1)
		Side.Left:
			return Vector2(0, position)
		Side.Top:
			return Vector2(position, 0)
		_:
			printerr("Invalid `Side` value.")
			assert(false)
			return Vector2()

############################################################
### \description Gets the normal of the side on which the 
###              door is.
###
func get_side_normal() -> Vector2:
	return side_normal(side)



############################################################
### \description Reverses the side and direction of the 
###              door. 
###
### \note This function returns a new instance. The current
###       one is not modified.
###
func reverse():
	return get_script().new(
		reverse_direction(direction),
		reverse_side(side),
		position
	)
