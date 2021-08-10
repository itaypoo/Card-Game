extends Node2D

onready var anim = $main_anim
var must_leave = false

func join(colorid):
	colorid = colorid - 1
	$sprites/leg_left.frame = colorid
	$sprites/leg_right.frame = colorid
	$sprites/head.frame = colorid
	$sprites/body.frame = colorid
	must_leave = false
	anim.play("ready")

func leave(): 
	must_leave = true

func _on_main_anim_animation_finished(anim_name):
	match anim_name:
		"ready": anim.play("join")
		"join": anim.play("idle")
		"idle": 
			if must_leave: anim.play("leave")
			else: anim.play("idle")
		"leave": must_leave = false
