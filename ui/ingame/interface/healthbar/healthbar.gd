extends TextureRect


### \description Width of the foreground's control.
const ForegroundWidth = 104

### \description Foreground part of the health bar
onready var fg = $foreground



############################################################
### \description Defines the value of the health bar.
###
### \param amnt : current amount of health
### \param max_amnt : maximum amount of health.
###
func set_value(amnt: float, max_amnt: float) -> void:
	fg.rect_size.x = ForegroundWidth * (amnt / max_amnt)
