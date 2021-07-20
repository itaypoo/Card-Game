extends Node2D


func _ready():
	get_parent().boss_hp += 100
	queue_free()
