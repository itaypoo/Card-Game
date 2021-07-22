extends Area2D

onready var coll_shape = $coll_shape

export (int) var bullet_speed = 2.5
var lifetime = 0

var vec_to_player = Vector2.ZERO


func _ready():
	vec_to_player = Vector2(bullet_speed, 0).rotated((global.player_pos - global_position).angle())
	look_at(global.player_pos)
	position += vec_to_player * 2
	
func _physics_process(_delta):
	position += vec_to_player
	lifetime += 1
	if lifetime > 700: queue_free()
	

func _on_boss_web_area_entered(area):
	if area.is_in_group("player"):
		area.set_speed(4, true)


func _on_boss_web_area_exited(area):
	if area.is_in_group("player"):
		area.set_speed(7, false)
