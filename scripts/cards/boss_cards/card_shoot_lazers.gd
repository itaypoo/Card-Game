extends Node2D

var lazer_cd = 0

var lazer_bullet = preload("res://scenes/boss_lazer.tscn")

func _physics_process(_delta):
	if lazer_cd >= 60:
		spawn_bullet()
		lazer_cd = 0
	lazer_cd += 1
	
	
func spawn_bullet():
	var bullet_inst = lazer_bullet.instance()
	bullet_inst.position = self.position
	get_parent().add_child(bullet_inst)
	bullet_inst.position.x -= 30 + bullet_inst.coll_shape.shape.extents.x
