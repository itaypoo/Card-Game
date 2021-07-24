extends Node2D

func _ready():
	get_tree().call_group("player", "add_health", 7)
