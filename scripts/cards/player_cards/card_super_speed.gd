extends Node2D

func _ready():
	get_tree().call_group("player", "set_speed", 15, false)
	get_tree().call_group("player", "set_default_speed", 15)
	queue_free()
