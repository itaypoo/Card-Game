extends Node2D

var lose_tex = preload("res://textures/defeat.png")
var win_tex = preload("res://textures/success.png")

func lose_screen():
	$text.texture = lose_tex
	$anim.play("play")

func win_screen():
	$text.texture = win_tex
	$anim.play("play")

func _on_anim_animation_finished(anim_name):
	transition.fade_out("res://scenes/leaderboard.tscn")
