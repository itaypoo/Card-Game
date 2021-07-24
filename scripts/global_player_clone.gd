extends Node2D

var clone_cd = 60

func _ready():
	$sprites/leg_left.frame = global.current_player - 1
	$sprites/leg_right.frame = global.current_player - 1
	$sprites/head.frame = global.current_player - 1
	$sprites/body.frame = global.current_player - 1

func _physics_process(_delta):
	if clone_cd >= 0: clone_cd -= 1
	else: queue_free()
