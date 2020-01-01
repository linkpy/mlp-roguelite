extends KinematicBody2D



### \description Movement speed of the player
export var movement_speed: float = 5 # m/s
### \description Acceleration amount of the player's jump.
export var jump_impulse: float = 12 # m/s²
### \description Maximum health of the player
export var maximum_health: float = 100

### \description FSM of the player
onready var fsm = $fsm
### \description Sprite of the player
onready var sprite = $sprite
### \description Animation controller of the player.
onready var animation = $animation

### \description Velocity of the player.
var velocity = Vector2() # m/s
### \description Health of the player
var health = 0



##################################################### _ready
func _ready() -> void:
	health = maximum_health



############################################################
### \description Move the player.
###
func move(dt: float) -> void:
	# update the player's velocity
	velocity.y += Constants.Gravity * dt
	
	# move the player based on its velocity
	move_and_slide(
		velocity * Constants.OneMeter, 
		Vector2(0, -1)
	)
	
	# correct the velocity based on the collisions that
	# happend during the motion
	for i in range(get_slide_count()):
		var c = get_slide_collision(i)
		
		velocity = velocity.slide(c.normal)



############################################################
### \description Get the movement input vector.
###
### Returns a vector based on the state of the actions
### `left`, `right`, `up`, `down`.
###
### \return A vector representing the state of the movement 
### input.
###
func get_movement_input_vector() -> Vector2:
	var m = Vector2()
	
	if Input.is_action_pressed("left"):
		m.x -= 1
	if Input.is_action_pressed("right"):
		m.x += 1
	if Input.is_action_pressed("up"):
		m.y -= 1
	if Input.is_action_pressed("down"):
		m.y += 1
	
	return m
