extends Node2D

onready var label = $label
var player_ticks = 0

func _physics_process(_delta):
	label.text = str(global.player_hp)
	if player_ticks > 0: 
		position = Vector2(global.player_pos.x, global.player_pos.y - 120)
		player_ticks -= 1
		scale = Vector2(1,1)
	else:
		position = Vector2(70, 70)
		scale = Vector2(1, 1)

func player_got_hurt(): player_ticks = 60
