extends Node2D

var lightning = preload("res://scenes/gloabal_ lightning.tscn")
var cd = 0

func _ready():
	randomize()
	cd = int(rand_range(60, 180))

func _physics_process(_delta):
	cd -= 1
	if cd <= 0:
		var inst = lightning.instance()
		get_tree().call_group("objects", "add_child", inst)
		cd = int(rand_range(60, 300))
