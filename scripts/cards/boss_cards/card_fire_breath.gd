extends Node2D

var fire_bullet = preload("res://scenes/boss_fire_breath.tscn")

var fire_cd = 0

func _physics_process(_delta):
	look_at(global.player_pos)
	if fire_cd >= 15:
		fire_cd = 0
		spawn_fire()
	else:
		fire_cd += 1
	
func spawn_fire():
	var bullet_inst = fire_bullet.instance()
	bullet_inst.position = self.global_position
	get_tree().call_group("objects", "add_child", bullet_inst)
	bullet_inst.position += Vector2(50, 0).rotated((global.player_pos - global_position).angle())
