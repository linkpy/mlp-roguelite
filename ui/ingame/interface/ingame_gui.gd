extends Control


export var player_path: NodePath

onready var player = get_node(player_path)
onready var healthbar = $healthbar



func _ready():
	healthbar.set_value(50, 100)
