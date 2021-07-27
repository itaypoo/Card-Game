extends Node2D

onready var label = $label
var player_ticks = 0

export (bool) var sticks_to_player = false

func _physics_process(_delta):
	label.text = str(global.player_hp)
	
	if player_ticks > 0:
		player_ticks -= 1
		visible = sticks_to_player
	else:
		visible = !sticks_to_player

func player_got_hurt(): player_ticks = 60
