extends Node2D

onready var boss_cards = $boss_cards
var curvelength = 100

func _ready():
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

func added_card(id):
	print("hi")
	var pathfollow = PathFollow2D.new()
	randomize()
	pathfollow.offset = rand_range(0, curvelength)
	var card = load(global.card_list[id])
	card = card.instance()
	pathfollow.add_child(card)
	boss_cards.add_child(pathfollow)

func _physics_process(_delta):
	for child in boss_cards.get_children(): child.offset += 1
	boss_cards.position = global.boss_pos
