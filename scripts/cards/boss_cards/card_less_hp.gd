extends Node2D


func _ready():
	get_tree().call_group("boss", "add_hp", -100)
	queue_free()
