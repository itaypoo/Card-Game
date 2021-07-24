extends Node2D

func _ready():
	get_tree().call_group("player", "set_weapon", 3, 40, 0.3, 0.8, 1)
	get_tree().call_group("player", "set_auto_aim", false)
	queue_free()
