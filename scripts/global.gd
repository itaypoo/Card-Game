extends Node2D

var player_pos = Vector2.ZERO
var current_player = 3

var active_cards = []

func added_card(id):
	active_cards.append(id)

# Card ID : Card Path
var card_list = {
	22: "res://scenes/cards/boss_cards/card_fire_breath.tscn",
	32: "res://scenes/cards/boss_cards/card_shoot_lazers.tscn",
	42: "res://scenes/cards/boss_cards/card_shoot_rockets.tscn"
}
