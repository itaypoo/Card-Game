extends Node2D

var player_pos = Vector2.ZERO
var boss_pos = Vector2.ZERO

var current_player = 3

var active_cards = []

###############################################################################

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
	24: "res://scenes/cards/global_cards/card_pig.tscn",
	34: "res://scenes/cards/global_cards/card_drugs.tscn",
	44: "res://scenes/cards/global_cards/card_pixelated.tscn",
	54: "res://scenes/cards/global_cards/card_wind.tscn",
	64: "res://scenes/cards/global_cards/card_lightning.tscn",
	74: "res://scenes/cards/global_cards/card_glitchy.tscn",
	84: "res://scenes/cards/global_cards/card_player_clone.tscn"
}

###############################################################################

onready var camera  = $camera

var screenshake = 0 
var hitstun = 0

###############################################################################

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _physics_process(_delta):
	if hitstun > 0: 
		get_tree().paused = true
		hitstun -= 1
	else: get_tree().paused = false
	
	camera.position = Vector2(640, 360)
	if screenshake > 0:
		camera.position += Vector2(clamp(screenshake, 0, 30), 0).rotated(deg2rad(rand_range(0, 360)))
		screenshake -= 1

###############################################################################

func set_hitstun(amount):
	if amount > hitstun: hitstun = amount

func set_screenshake(amount):
	if amount > screenshake: screenshake = amount
