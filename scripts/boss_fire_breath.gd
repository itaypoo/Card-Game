extends Area2D

onready var coll_shape = $coll_shape

export (int) var bullet_speed = 3
var lifetime = 0

var vec_to_player = Vector2.ZERO

func _ready():
	vec_to_player = Vector2(bullet_speed, 0).rotated((global.player_pos - global_position).angle())
	look_at(global.player_pos)
	position += vec_to_player * 2

func _physics_process(_delta):
	position += vec_to_player
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			area.hurt_player(1)
	
	lifetime += 1
	if lifetime > 50: queue_free()
