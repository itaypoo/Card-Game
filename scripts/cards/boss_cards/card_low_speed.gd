extends Node2D


func _ready():
	get_tree().call_group("boss", "set_speed", 0.5)
	queue_free()
