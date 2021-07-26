extends Node2D

func _ready():
	for player in get_tree().get_nodes_in_group("player"):
		player.friction = 0.05
	queue_free()
