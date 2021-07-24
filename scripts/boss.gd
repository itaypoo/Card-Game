extends Area2D

var boss_hp = 100
var speed_multiplier = 1

func  _physics_process(_delta):
	global.boss_pos = global_position

func hurt_boss(hp):
	boss_hp -= hp
	print(boss_hp)
	if boss_hp <= 0:
		queue_free()

func added_card(id):
	var card = load(global.card_list[id])
	card = card.instance()
	$boss_cards.add_child(card)
	
	
func add_hp(hp):
	boss_hp += hp

func set_speed(speed):
	speed_multiplier = speed
