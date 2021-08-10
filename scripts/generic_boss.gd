extends Area2D

var boss_hp = 200
var speed_multiplier = 1

func _ready():
	position = Vector2(960, 540)

func  _physics_process(_delta):
	global.boss_pos = global_position
	keep_in_bounds()

func hurt_boss(hp):
	global.player_scores[global.current_player - 1] += hp
	boss_hp -= hp
	if boss_hp <= 0:
		get_tree().call_group("winlose_screen", "win_screen")
		queue_free()

func added_card(id):
	var card = load(global.card_list[id])
	card = card.instance()
	$boss_cards.add_child(card)
	
	
func add_hp(hp):
	boss_hp += hp

func set_speed(speed):
	speed_multiplier = speed

func keep_in_bounds():
	if position.x > 1920: position.x = 1920
	elif position.x < 0: position.x = 0
	if position.y > 1080: position.y = 1080
	elif position.y < 0: position.y = 0
