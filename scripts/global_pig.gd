extends Area2D

var lifetime
var delay_kill = -1

var kill = false

func _ready():
	randomize()
	position = Vector2(int (rand_range(50, 1230)), -50)
	randomize()
	lifetime = int (rand_range(50, 200))
	
func _physics_process(_delta):
	if kill and delay_kill >= 0:
		delay_kill -= 1
	elif kill:
		queue_free()
	if not kill:
		position.y += 3
		lifetime -= 1
		if lifetime > 0:
			for area in get_overlapping_areas():
				if area.is_in_group("player"):
					boom()
		elif lifetime == 0:
			boom()
		

func boom():
	$circle_coll.disabled = false
	print('')
	$Timer.start(0.1)


func _on_Timer_timeout():
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			area.hurt_player(1)
	$sprite.visible = false
	delay_kill = 180
	kill = true
