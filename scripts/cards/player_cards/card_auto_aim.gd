extends Node2D

func _ready():
	get_tree().call_group("player", "set_weapon", 10, 20, 0.5, 1, 1)
	get_tree().call_group("player", "set_auto_aim", true)
	queue_free()
