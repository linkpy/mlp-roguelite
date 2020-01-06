### \description Master script of the first player attack.
###
### \note The attack is mostly controlled by the animation
###       player. The later calls the `do_attack` method
###       and the `queue_free` method at the end of the 
###       animation.
###
extends Area2D



### \description Player instance.
var player



############################################################
### \describe Executes the attack.
###
func do_attack() -> void:
	# applies damages to enemies in the area
	for body in get_overlapping_bodies():
		if body.has_method("apply_damages"):
			body.apply_damages(
				player,
				player.stats.get_attack()
			)
