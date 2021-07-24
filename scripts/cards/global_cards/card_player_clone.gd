extends Node2D

var spawn_cd = 10

var player_clone = preload("res://scenes/global_player_clone.tscn")

func _physics_process(_delta):
	if spawn_cd >= 0: spawn_cd -= 1
	else:
		spawn_clone()
		spawn_cd = 10

func spawn_clone():
	var clone = player_clone.instance()
	clone.position = global.player_pos + random_pos()
	get_tree().call_group("objects", "add_child", clone)
	
func random_pos():
	var random_pos = Vector2.ZERO
	randomize()
	random_pos.x = rand_range(-70, 70)
	randomize()
	random_pos.y = rand_range(-70, 70)
	return random_pos
