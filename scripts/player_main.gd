extends Area2D

onready var sprites_node = $sprites
onready var walk_anim = $walk_anim
onready var gun = $gun

var player_bullet = preload("res://scenes/player_bullet.tscn")

export (int) var move_speed = 5
var shoot_cd = 0
var player_hp = 10
var invis = 0

var moving = false

var is_slow = false

func _ready():
	$sprites/leg_left.frame = global.current_player - 1
	$sprites/leg_right.frame = global.current_player - 1
	$sprites/head.frame = global.current_player - 1
	$sprites/body.frame = global.current_player - 1
	$gun/hand.frame = global.current_player - 1

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
		sprites_node.scale.x = -0.5
		moving = true
	elif Input.is_action_pressed("player_right"): 
		position.x += move_speed
		sprites_node.scale.x = 0.5
		moving = true
	
	if moving:
		var speed = 1.0
		if is_slow:
			speed = 0.35
		walk_anim.play("run", -1, speed)
		if sprites_node.scale.x == 0.5: sprites_node.rotation_degrees = 6
		else: sprites_node.rotation_degrees = -6
	else: walk_anim.play("ready")
	
	if shoot_cd <= 0 and Input.is_action_pressed("player_shoot"): 
		spawn_bullet()
		shoot_cd = 10
	shoot_cd -= 1
	if invis > 0: 
		invis -= 1
		sprites_node.material.set_shader_param("flash_modifier", 0.8)
	else: sprites_node.material.set_shader_param("flash_modifier", 0)
	
	gun.position = Vector2(-60, 0).rotated((position - get_global_mouse_position()).angle())
	gun.look_at(get_global_mouse_position())

##############################################################################

func hurt_player(hp):
	if invis <= 0:
		player_hp -= hp
		invis = 30
		print(player_hp)
		if player_hp <= 0:
			queue_free()

##############################################################################

func spawn_bullet():
	var bullet_inst = player_bullet.instance()
	bullet_inst.position = position + Vector2(-100, 0).rotated((global_position - get_global_mouse_position()).angle())
	get_parent().add_child(bullet_inst)

##############################################################################

func set_speed(speed, is_slow):
	move_speed = speed
	self.is_slow = is_slow
	
