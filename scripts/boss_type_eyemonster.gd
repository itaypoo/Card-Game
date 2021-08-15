extends "res://scripts/generic_boss.gd"

onready var eye = $sprites/eye
export (bool) var rotate_eye = true

var shadow = preload("res://scenes/eyemonster_shadow.tscn")

###############################################################################

func _ready():
	boss_hp = 250

###############################################################################

func _physics_process(_delta):
	if rotate_eye:
		eye.look_at(Vector2(global.player_pos.x, global.player_pos.y + 20))
		eye.position = Vector2(45, 0).rotated(eye.rotation)

###############################################################################

func _on_teleport_timer_timeout():
	$teleport_anim.play("teleport")

###############################################################################

func _on_teleport_anim_animation_finished(anim_name):
	var oldpos = global_position
	$sprites/smoke_particle.emitting = true
	$sprites/eye_particle.emitting = true
	randomize()
	position.x = rand_range(100, 1820)
	randomize()
	position.y = rand_range(100, 1180)
	
	var distance = oldpos.distance_to(global_position)
	var angle = (oldpos - global_position).angle()
	for i in range(1, 10):
		var shadow_inst = shadow.instance()
		shadow_inst.position = oldpos + Vector2(-(distance / 10) * i, 0).rotated(angle)
		shadow_inst.rotation_degrees = rad2deg(angle) + 180
		get_parent().add_child(shadow_inst)
