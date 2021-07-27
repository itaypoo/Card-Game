extends Node2D

func _ready():
	randomize()
	$goat.frame = int(rand_range(0, 6)) 

func _physics_process(_delta):
	position = global.get_zero_pos()

func _on_anim_animation_finished(anim_name):
	$anim.play("anim")
	randomize()
	$goat.frame = int(rand_range(0, 6)) 
