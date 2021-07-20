extends Area2D

onready var sprites_node = $sprites

var player_bullet = preload("res://scenes/player_bullet.tscn")

export (int) var move_speed = 5
var shoot_cd = 0
var player_hp = 10
var invis = 0

var moving = false

##############################################################################

func _physics_process(_delta):
	global.player_pos = self.position
	moving = false
	
	if Input.is_action_pressed("player_up"): 
		position.y -= move_speed
		moving = true
	elif Input.is_action_pressed("player_down"): 
		position.y += move_speed
		moving = true
	if Input.is_action_pressed("player_left"): 
		position.x -= move_speed
		sprites_node.scale.x = -0.6
		moving = true
	elif Input.is_action_pressed("player_right"): 
		position.x += move_speed
		sprites_node.scale.x = 0.6
		moving = true
	
	if moving: pass
	
	if shoot_cd <= 0 and Input.is_action_pressed("player_shoot"): 
		spawn_bullet()
		shoot_cd = 10
	shoot_cd -= 1
	if invis > 0: invis -= 1

##############################################################################

func hurt_player(hp):
	if invis <= 0:
		player_hp -= hp
		invis = 20
		print(player_hp)
		if player_hp <= 0:
			queue_free()

##############################################################################

func spawn_bullet():
	var bullet_inst = player_bullet.instance()
	bullet_inst.position = self.position
	get_parent().add_child(bullet_inst)
	bullet_inst.position.x += $coll_shape.shape.extents.x + bullet_inst.coll_shape.shape.extents.x
