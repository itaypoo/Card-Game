extends Node2D

func _ready():
	get_tree().call_group("player", "set_weapon", 40, 20, 4, 1, 1)
	get_tree().call_group("player", "set_auto_aim", false)
	get_tree().call_group("player", "set_gun_texture", "res://textures/cards/player_cards/sniper_sheet.png")
	queue_free()

