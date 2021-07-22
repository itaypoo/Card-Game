extends Node2D


func _ready():
	get_tree().call_group("boss", "set_speed", 2)
	queue_free()
