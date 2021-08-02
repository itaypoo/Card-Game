extends Area2D

onready var coll_shape = $coll_shape

export (int) var minion_speed = 4
var minion_hp = 3
var moving = 0

var vec_to_player = Vector2.ZERO
var rot_to_player = 0

########################################################################

func _physics_process(_delta):
	rot_to_player = (global_position - global.player_pos).angle()
	if moving == 0 and position.distance_to(global.player_pos) > 5:
		position += Vector2(-minion_speed, 0).rotated(rot_to_player)
	
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			area.hurt_player(1)
			moving = 25
	
	if moving > 0:
		moving -= 1
		position += Vector2(-3, 0).rotated(rot_to_player)
	
	if rad2deg(rot_to_player) > 90 or rad2deg(rot_to_player) < -90:
		scale.x = -1
	else:
		scale.x = 1

func hurt_minion(hp):
	minion_hp -= hp
	print('b')
	if minion_hp <= 0:
		queue_free()
