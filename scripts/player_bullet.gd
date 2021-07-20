extends Area2D

onready var coll_shape = $coll_shape
export (int) var bullet_speed = 7
var lifetime = 0

func _physics_process(_delta):
	position.x += bullet_speed
	lifetime += 1
	if lifetime > 500: queue_free()
