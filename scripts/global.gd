extends Node2D

var player_pos = Vector2.ZERO
var boss_pos = Vector2.ZERO

var current_player = 4

var active_cards = []

# Card ID : Card Path
var card_list = {
	22: "res://scenes/cards/boss_cards/card_fire_breath.tscn",
	32: "res://scenes/cards/boss_cards/card_shoot_lazers.tscn",
	42: "res://scenes/cards/boss_cards/card_shoot_rockets.tscn",
	62: "res://scenes/cards/boss_cards/card_low_speed.tscn",
	72: "res://scenes/cards/boss_cards/card_high_speed.tscn",
	82: "res://scenes/cards/boss_cards/card_more_hp.tscn",
	92: "res://scenes/cards/boss_cards/card_less_hp.tscn"
}
