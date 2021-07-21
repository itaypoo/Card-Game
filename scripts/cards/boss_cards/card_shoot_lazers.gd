extends Node2D

var lazer_bullet = preload("res://scenes/boss_lazer.tscn")

func _physics_process(_delta):
	look_at(global.player_pos)

func spawn_bullet():
	var bullet_inst = lazer_bullet.instance()
	bullet_inst.position = self.position
	get_parent().add_child(bullet_inst)
	bullet_inst.position += Vector2(30 + bullet_inst.coll_shape.shape.extents.x, 0).rotated((global.player_pos - global_position).angle())


func _on_shoot_anim_animation_finished(anim_name): 
	spawn_bullet()
	$shoot_anim.play("shoot")
	
