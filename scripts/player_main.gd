extends Area2D

export (int) var move_speed = 5
var player_bullet = preload("res://scenes/player_bullet.tscn")

var shoot_cd = 0

var player_hp = 10

func _physics_process(_delta):
	global.player_pos = self.position
	if Input.is_action_pressed("player_up"): position.y -= move_speed
	elif Input.is_action_pressed("player_down"): position.y += move_speed
	if Input.is_action_pressed("player_left"): position.x -= move_speed
	elif Input.is_action_pressed("player_right"): position.x += move_speed
	
	if shoot_cd <= 0 and Input.is_action_pressed("player_shoot"): 
		spawn_bullet()
		shoot_cd = 10
	shoot_cd -= 1

func hurt_player():
	player_hp -= 1
	print(player_hp)
	if player_hp <= 0:
		queue_free()
		
func spawn_bullet():
	var bullet_inst = player_bullet.instance()
	bullet_inst.position = self.position
	get_parent().add_child(bullet_inst)
	bullet_inst.position.x += $coll_shape.shape.extents.x + bullet_inst.coll_shape.shape.extents.x
