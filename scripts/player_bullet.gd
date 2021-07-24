extends Area2D

onready var coll_shape = $coll_shape
export (int) var bullet_speed = 20
var bullet_damage = 1
var bullet_size = 1
var lifetime = 0

var auto_aim = false
var main_bullet = false

var move_vec = Vector2(0,0)

func _ready():
	scale = Vector2(bullet_size, bullet_size)
	$sprite.frame = global.current_player - 1
	if not auto_aim:
		look_at(global.player_pos)
		move_vec = Vector2(-bullet_speed, 0).rotated(rotation)
	else:
		move_vec = Vector2(bullet_speed, 0).rotated(rotation)

func _physics_process(_delta):
	if auto_aim:
		look_at(global.boss_pos)
		move_vec = Vector2(bullet_speed, 0).rotated(rotation)
	position += move_vec
	lifetime += 1
	if lifetime > 500: queue_free()

func _on_player_bullet_area_entered(area):
	if area.is_in_group("boss"):
		area.hurt_boss(bullet_damage)
		queue_free()
	if area.is_in_group("minion"):
		area.hurt_minion(bullet_damage)
		queue_free()
