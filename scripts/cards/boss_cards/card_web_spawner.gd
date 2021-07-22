extends Node2D

var web_bullet = preload("res://scenes/boss_rocket.tscn")

func _physics_process(_delta):
	look_at(global.player_pos)
	
func spawn_bullet():
	var bullet_inst = web_bullet.instance()
	bullet_inst.position = self.global_position
	get_tree().call_group("objects", "add_child", bullet_inst)
	bullet_inst.position += Vector2(50, 0).rotated((global.player_pos - global_position).angle())

func _on_shoot_anim_animation_finished(anim_name):
	spawn_bullet()
	$spawn_anim.play("spawn")
