extends Node2D

var rocket_cd = 0

var rocket_bullet = preload("res://scenes/boss_rocket.tscn")

func _physics_process(_delta):
	if rocket_cd >= 100:
		spawn_bullet()
		rocket_cd = 0
	rocket_cd += 1

func spawn_bullet():
	var bullet_inst = rocket_bullet.instance()
	bullet_inst.position = self.position
	get_parent().add_child(bullet_inst)
	bullet_inst.position += Vector2(30 + bullet_inst.coll_shape.shape.extents.x, 0).rotated((global.player_pos - global_position).angle())
