extends Area2D

onready var coll_shape = $coll_shape
export (int) var bullet_speed = 7
var lifetime = 0
var move_vec = Vector2(0,0)

func _ready():
	$sprite.frame = global.current_player - 1
	look_at(global.player_pos)
	move_vec = Vector2(-bullet_speed, 0).rotated(rotation)

func _physics_process(_delta):
	position += move_vec
	lifetime += 1
	if lifetime > 500: queue_free()

func _on_player_bullet_area_entered(area):
	if area.is_in_group("boss"):
		area.hurt_boss()
		queue_free()
	if area.is_in_group("minion"):
		area.hurt_minion()
		queue_free()
