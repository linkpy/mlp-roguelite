extends TextureRect


const ForegroundWidth = 104

onready var fg = $foreground



func set_value(amnt: float, max_amnt: float) -> void:
	fg.rect_size.x = ForegroundWidth * (amnt / max_amnt)
