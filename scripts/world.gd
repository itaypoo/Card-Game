extends Node2D

onready var boss_cards = $boss_cards
var curvelength = 100

var bosses_path = ["res://scenes/boss_type_cat.tscn", "res://scenes/boss_type_eyemonster.tscn"]

func _ready():
	global.ingame = true
	var r = 170
	var newcurve = Curve2D.new()
	newcurve.add_point(Vector2(r,0),Vector2(0,-r))
	newcurve.add_point(Vector2(0,r),Vector2(r,0))
	newcurve.add_point(Vector2(-r,0),Vector2(0,r))
	newcurve.add_point(Vector2(0,-r),Vector2(-r,0))
	newcurve.add_point(Vector2(r,0),Vector2(0,-r))
	newcurve.set_bake_interval(2)
	curvelength = newcurve.get_baked_length()
	
	boss_cards.curve = newcurve
	
	for child in $background_tiles.get_children():
		child.frame = int(rand_range(0, 3))
	
	for card in global.active_cards:
		added_card(card)
	
	randomize()
	var boss_type = int(rand_range(0, bosses_path.size()))
	var boss_inst = load(bosses_path[boss_type])
	boss_inst = boss_inst.instance()
	boss_inst.position = Vector2(960, 540)
	$objects.add_child(boss_inst)

func added_card(id):
	if (id % 10) == 2:
		# Boss Card
		var pathfollow = PathFollow2D.new()
		randomize()
		pathfollow.offset = rand_range(0, curvelength)
		var card = load(global.card_list[id])
		card = card.instance()
		pathfollow.add_child(card)
		boss_cards.add_child(pathfollow)
	elif (id % 10) == 4:
		# Global Card
		var card = load(global.card_list[id])
		card = card.instance()
		$global_cards.add_child(card)
	elif (id % 10) == 3:
		# Player card
		var card = load(global.card_list[id])
		card = card.instance()
		get_tree().call_group("player", "add_child", card)

func _physics_process(_delta):
	for child in boss_cards.get_children(): child.offset += 1
	boss_cards.position = global.boss_pos
