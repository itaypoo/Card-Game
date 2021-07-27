extends Node2D

onready var text = $text
var input = 0

export (bool) var spawn_random = false

func _ready():
	var card = 0
	for i in range(0, 4):
		randomize()
		card = int(rand_range(0, global.cards.size()))
		get_tree().call_group("world", "added_card", global.cards[card])
		global.active_cards.append(global.cards[card])
		print("Added Card - ", card, ", ID ", global.cards[card])

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			var num
			if Input.is_action_just_pressed("0"): num = 0
			elif Input.is_action_just_pressed("1"): num = 1
			elif Input.is_action_just_pressed("2"): num = 2
			elif Input.is_action_just_pressed("3"): num = 3
			elif Input.is_action_just_pressed("4"): num = 4
			elif Input.is_action_just_pressed("5"): num = 5
			elif Input.is_action_just_pressed("6"): num = 6
			elif Input.is_action_just_pressed("7"): num = 7
			elif Input.is_action_just_pressed("8"): num = 8
			elif Input.is_action_just_pressed("9"): num = 9
			
			if num:
				input *= 10
				input += num
			text.text = str("Insert Card >> ", input)
			
			if Input.is_action_just_pressed("enter"): 
				if global.card_list.has(input):
					get_tree().call_group("world", "added_card", input)
					global.active_cards.append(input)
					text.text = "Added Card"
				else:
					text.text = "Invalid Card ID"
				input = 0
			
