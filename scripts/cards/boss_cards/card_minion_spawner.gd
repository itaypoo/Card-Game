extends Node2D

var lazer_bullet = preload("res://scenes/boss_minion.tscn")

func _physics_process(_delta):
	look_at(global.player_pos)

func spawn_bullet():
	var bullet_inst = lazer_bullet.instance()
	bullet_inst.position = self.global_position
	get_tree().call_group("objects", "add_child", bullet_inst)
	

func _on_spawn_anim_animation_finished(_anim_name): 
	spawn_bullet()
	$spawn_anim.play("spawn")
