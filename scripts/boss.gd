extends "res://scripts/generic_boss.gd"

var move_dir
var moving = false

func _ready():
	boss_hp = 300

func _on_jump_anim_animation_finished(anim_name):
	if anim_name == "jump":
		moving = false
		global.set_screenshake(70)
		$jump_anim.play("wait")
	elif anim_name == "wait":
		$jump_anim.play("jump")
		moving = true
		move_dir = (global.player_pos - position).angle()

func _physics_process(_delta):
	if moving:
		position += Vector2(7 * speed_multiplier, 0).rotated(move_dir)
	for area in get_overlapping_areas():
		if area.is_in_group("player"): area.hurt_player(1)
