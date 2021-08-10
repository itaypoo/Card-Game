extends Node2D

var pig = preload("res://scenes/global_pig.tscn")

var spawn_cd = 180

func _physics_process(_delta):
	if spawn_cd > 0:
		spawn_cd -= 1
	else:
		spawn_pig()
		randomize()
		spawn_cd = rand_range(50, 150)

func spawn_pig():
	var pig_inst = pig.instance()
	pig_inst.position = self.global_position
	get_tree().call_group("objects", "add_child", pig_inst)
