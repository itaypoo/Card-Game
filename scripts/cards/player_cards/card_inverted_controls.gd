extends Node2D


func _ready():
	global.inverted_controls = true
	get_tree().call_group("player", "reverse_move_speed")
	queue_free()
