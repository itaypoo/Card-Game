extends Area2D

onready var slow_particle = $slow_particle
onready var invis_anim = $invis_anim
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

var gun_cd = 10
var gun_speed = 20
var gun_damage = 1
var gun_bullet_size = 1
var gun_amount = 1
var gun_auto_aim = false

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
		var anim_speed = 1.0
		if is_slow:
			anim_speed = 0.35
		walk_anim.play("run", -1, anim_speed)
		if sprites_node.scale.x == 0.5: sprites_node.rotation_degrees = 6
		else: sprites_node.rotation_degrees = -6
	else: walk_anim.play("ready")
	
	if shoot_cd <= 0 and Input.is_action_pressed("player_shoot"): 
		spawn_bullet()
		shoot_cd = gun_cd
	shoot_cd -= 1
	if invis > 0: 
		invis -= 1
		invis_anim.play("invis", -1, 2)
	else: invis_anim.play("ready")
	
	gun.position = Vector2(-60, 0).rotated((position - get_global_mouse_position()).angle())
	gun.look_at(get_global_mouse_position())
	slow_particle.emitting = is_slow

##############################################################################

func hurt_player(hp):
	if invis <= 0:
		player_hp -= hp
		invis = 30
		$hurt_anim.play("hurt")
		global.set_hitstun(4)
		global.set_screenshake(5)
		if player_hp <= 0:
			queue_free()

##############################################################################

func spawn_bullet():
	for i in range(0,gun_amount):
		print(i)
		var bullet_inst = player_bullet.instance()
		var y = 0
		if not i == 0:
			if i % 2 == 0: y = 1
			else: y = -1
			y = i*3*y
		bullet_inst.position = position + Vector2(-100, y).rotated((global_position - get_global_mouse_position()).angle())
		bullet_inst.bullet_speed = gun_speed
		bullet_inst.bullet_damage = gun_damage
		bullet_inst.bullet_size = gun_bullet_size
		bullet_inst.auto_aim = gun_auto_aim
		if i > 0: bullet_inst.main_bullet = false
		else: bullet_inst.main_bullet = true
		get_parent().add_child(bullet_inst)

##############################################################################

func set_speed(speed, is_slow):
	move_speed = speed
	self.is_slow = is_slow
	
func set_pos(pos):
	position = pos

func add_pos(pos):
	position += pos
	
func reverse_move_speed():
	move_speed *= -1
	
func add_health(hp):
	player_hp += hp

func set_weapon(cd, speed, damage, size, amount):
	gun_cd = cd
	gun_speed = speed
	gun_damage = damage
	gun_bullet_size = size
	gun_amount = amount

func set_auto_aim(auto_aim):
	gun_auto_aim = auto_aim
