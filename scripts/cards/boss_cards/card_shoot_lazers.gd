extends Node2D

var lazer_bullet = preload("res://scenes/boss_lazer.tscn")

func _physics_process(_delta):
	look_at(global.player_pos)

func spawn_bullet():
	var bullet_inst = lazer_bullet.instance()
	bullet_inst.position = self.global_position
	get_tree().call_group("objects", "add_child", bullet_inst)
	


func _on_shoot_anim_animation_finished(anim_name): 
	spawn_bullet()
	$shoot_anim.play("shoot")
	
