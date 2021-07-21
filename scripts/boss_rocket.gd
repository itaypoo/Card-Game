extends Area2D

onready var coll_shape = $coll_shape
export (int) var bullet_speed = 6
var lifetime = 0
var vec_to_player = Vector2.ZERO

########################################################################

func _ready():
	vec_to_player = Vector2(bullet_speed, 0).rotated((global.player_pos - global_position).angle())
	rotation = (global.player_pos - global_position).angle()
	
########################################################################

func _physics_process(_delta):
	position += vec_to_player
	lifetime += 1
	if lifetime > 700: queue_free()

########################################################################

func _on_boss_rocket_area_entered(area):
	if area.is_in_group("player"):
		area.hurt_player(1)
		queue_free()
