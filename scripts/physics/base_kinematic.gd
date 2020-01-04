### \description Base class for all kinematic objects.
###
### It implements common movement code including gravity
### and velocity. Velocity management is up to the inherited
### classes.
###
class_name BaseKinematic
extends KinematicBody2D



### \description Velocity of the object.
var velocity: Vector2 = Vector2()



############################################################
### \description Applies a force impulse to the object's
###              velocity.
###
### \param dir : Direction of the impulse.
### \param force : Impulse's force.
###
func impule(dir: Vector2, force: float) -> void:
	var vel_diff = dir.normalized() * force
	velocity += vel_diff



############################################################
### \description Move the kinematic object.
###
### \param dt : Delta time.
### \parma hbounce : True if the object should bounce when
###        colliding with a wall.
###
func move(dt: float, hbounce: bool = false) -> void:
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
		
		# if the object hit a wall and should bounce
		if c.normal.abs() == Vector2(1, 0) and hbounce:
			velocity.x *= -1
		else:
			velocity = velocity.slide(c.normal)
