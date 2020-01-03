class_name BaseKinematic
extends KinematicBody2D



### \description Velocity of the object.
var velocity: Vector2 = Vector2()



############################################################
### \description Move the kinematic object.
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
