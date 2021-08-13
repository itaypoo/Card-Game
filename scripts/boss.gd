extends "res://scripts/generic_boss.gd"

var move_dir
var moving = false

func _ready():
	boss_hp = 300

func _on_jump_timer_timeout():
	$jump_anim.play("jump")
	moving = true
	randomize()
	move_dir = int(rand_range(0, 360))

func _on_jump_anim_animation_finished(anim_name):
	moving = false
	global.set_screenshake(70)

func _physics_process(_delta):
	if moving:
		position += Vector2(5 * speed_multiplier, 0).rotated(deg2rad(move_dir))
