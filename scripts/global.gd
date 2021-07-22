extends Node2D

var player_pos = Vector2.ZERO
var boss_pos = Vector2.ZERO

var current_player = 4

var active_cards = []

# Card ID : Card Path
var card_list = {
	12: "res://scenes/cards/boss_cards/card_minion_spawner.tscn",
	22: "res://scenes/cards/boss_cards/card_fire_breath.tscn",
	32: "res://scenes/cards/boss_cards/card_shoot_lazers.tscn",
	42: "res://scenes/cards/boss_cards/card_shoot_rockets.tscn",
	52: "res://scenes/cards/boss_cards/card_web_spawner.tscn",
	62: "res://scenes/cards/boss_cards/card_low_speed.tscn",
	72: "res://scenes/cards/boss_cards/card_high_speed.tscn",
	82: "res://scenes/cards/boss_cards/card_more_hp.tscn",
	92: "res://scenes/cards/boss_cards/card_less_hp.tscn",
	14: "res://scenes/cards/global_cards/card_goat_pics.tscn",
	34: "res://scenes/cards/global_cards/card_drugs.tscn",
	44: "res://scenes/cards/global_cards/card_pixelated.tscn"
}
