extends Area2D

onready var hurt_anim = $hurt_anim

var boss_hp = 200
var speed_multiplier = 1

var time_bonus = 100.0
var timer = 0

###############################################################################

func _ready():
	add_to_group("boss")
	position = Vector2(960, 540)

func  _physics_process(_delta):
	global.boss_pos = global_position
	keep_in_bounds()
	
	timer += 1
	if timer >= 60:
		timer = 0
		if time_bonus > 0: time_bonus -= 0.5555555555

###############################################################################

func hurt_boss(hp):
	hurt_anim.stop()
	hurt_anim.play("hurt")
	global.player_scores[global.current_player - 1] += hp
	boss_hp -= hp
	if boss_hp <= 0:
		#global.player_scores[global.current_player - 1] += time_bonus
		get_tree().call_group("winlose_screen", "win_screen")
		queue_free()

func keep_in_bounds():
	if position.x > 1920: position.x = 1920
	elif position.x < 0: position.x = 0
	if position.y > 1080: position.y = 1080
	elif position.y < 0: position.y = 0

###############################################################################

func added_card(id):
	var card = load(global.card_list[id])
	card = card.instance()
	$boss_cards.add_child(card)

func player_died(): global.player_scores[global.current_player - 1] += time_bonus

func add_hp(hp): boss_hp += hp

func set_speed(speed): speed_multiplier = speed

