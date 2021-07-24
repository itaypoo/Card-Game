extends Area2D

onready var coll_shape = $coll_shape

export (int) var minion_speed = 4
var minion_hp = 3
var moving = 0

var vec_to_player = Vector2.ZERO

########################################################################

func _physics_process(_delta):
	look_at(global.player_pos)
	if moving == 0 and position.distance_to(global.player_pos) > 5:
		position += Vector2(minion_speed, 0).rotated(rotation)
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			area.hurt_player(1)
			moving = 25
	if moving > 0:
		moving -= 1
		position += Vector2(-3, 0).rotated(rotation)
			
func hurt_minion(hp):
	minion_hp -= hp
	print('b')
	if minion_hp <= 0:
		queue_free()
