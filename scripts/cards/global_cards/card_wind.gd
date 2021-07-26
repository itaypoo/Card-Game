extends Node2D

var y = 0
var x = 0

func _ready():
	random_pos()
	
func _physics_process(_delta):
	print(x)
	print(y)
	get_tree().call_group("player", "add_pos", Vector2(x, y))

func _on_Timer_timeout():
	random_pos()

func random_pos():
	randomize()
	match int (rand_range(0, 2)):
		0:
			y = 0
		1:
			y = 1
		2:
			y = -1
	randomize()
	var rand_min = 0
	if y == 0: rand_min = 1
	match int (rand_range(rand_min, 2)):
		0:
			x = 0
		1:
			x = 1
		2:
			x = -1
	
	$wind_particle.restart()
	$wind_particle.rotation = (Vector2(x,y)).angle()
