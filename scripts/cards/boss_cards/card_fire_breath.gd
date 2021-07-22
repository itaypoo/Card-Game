extends Area2D

onready var coll_shape = $coll_shape

func _physics_process(_delta):
	look_at(global.player_pos)
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			area.hurt_player(1)
