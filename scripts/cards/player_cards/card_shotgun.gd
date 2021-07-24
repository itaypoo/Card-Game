extends Node2D

func _ready():
	get_tree().call_group("player", "set_weapon", 40, 20, 1, 1.5, 4)
	get_tree().call_group("player", "set_auto_aim", false)
	queue_free()
