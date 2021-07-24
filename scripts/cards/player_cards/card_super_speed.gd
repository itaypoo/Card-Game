extends Node2D

func _ready():
	get_tree().call_group("player", "set_speed", 15, false)
	queue_free()
