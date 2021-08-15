extends Node2D

func _ready():
	randomize()
	$sprite.frame = int(rand_range(0, 3))

func _on_anim_animation_finished(anim_name):
	queue_free()
