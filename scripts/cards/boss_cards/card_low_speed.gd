extends Node2D


func _ready():
	get_parent().speed_multiplier = 0.5
	queue_free()
