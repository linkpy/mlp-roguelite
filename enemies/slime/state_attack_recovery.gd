extends FSM_State



func enter(data) -> void:
	object.animation.play("attack_recovery")
