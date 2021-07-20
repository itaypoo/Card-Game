extends Node2D


func _ready():
	get_parent().speed_multiplier = 2
	queue_free()
