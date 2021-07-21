extends Area2D

onready var coll_shape = $coll_shape
export (int) var bullet_speed = 7
var lifetime = 0

func _ready():
	$sprite.frame = global.current_player - 1

func _physics_process(_delta):
	position.x += bullet_speed
	lifetime += 1
	if lifetime > 500: queue_free()

func _on_player_bullet_area_entered(area):
	if area.is_in_group("boss"):
		area.hurt_boss()
		queue_free()
