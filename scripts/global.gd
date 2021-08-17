extends Node2D

var player_pos = Vector2.ZERO
var boss_pos = Vector2.ZERO
var player_hp = 0

var play_style = "app"

var current_player = 1

var active_cards = []

var inverted_controls = false
var ingame = false

var player_scores = [10, 10, 10, 10]
var player_names = ["P1", "P2", "P3", "P4"]

# Server:
#var domain = "http://localhost:8080/"
var domain = "http://deltacube.network:8083/"
var user = "CardGame1@"
var password = "qpEvsnK98JfhHgCd"

var game_id = -1

var shutting_down = false

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
	13: "res://scenes/cards/player_cards/card_inverted_controls.tscn",
	23: "res://scenes/cards/player_cards/card_super_speed.tscn",
	33: "res://scenes/cards/player_cards/card_slippery.tscn",
	43: "res://scenes/cards/player_cards/card_more_hp.tscn",
	53: "res://scenes/cards/player_cards/card_shotgun.tscn",
	63: "res://scenes/cards/player_cards/card_machine_gun.tscn",
	73: "res://scenes/cards/player_cards/card_sniper.tscn",
	83: "res://scenes/cards/player_cards/card_auto_aim.tscn",
	14: "res://scenes/cards/global_cards/card_goat_pics.tscn",
	24: "res://scenes/cards/global_cards/card_pig.tscn",
	34: "res://scenes/cards/global_cards/card_drugs.tscn",
	44: "res://scenes/cards/global_cards/card_pixelated.tscn",
	54: "res://scenes/cards/global_cards/card_wind.tscn",
	64: "res://scenes/cards/global_cards/card_lightning.tscn",
	74: "res://scenes/cards/global_cards/card_glitchy.tscn",
	84: "res://scenes/cards/global_cards/card_player_clone.tscn"
}

var cards = [12, 22, 32, 42, 52, 62, 72, 82, 92, 13, 23, 33, 43, 53, 63, 73, 83, 14, 24, 34, 44, 54, 64, 74, 84]
###############################################################################

onready var camera  = $camera

var screenshake = 0 
var hitstun = 0

###############################################################################

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().set_auto_accept_quit(false)
	
func _physics_process(_delta):
	if hitstun > 1: 
		get_tree().paused = true
		hitstun -= 1
	else: 
		if hitstun == 1: get_tree().paused = false
	
	if ingame:
		camera.position = global.player_pos
		camera.smoothing_enabled = true
		camera.limit_smoothed = true
	else:
		camera.position = Vector2(640, 360)
		camera.smoothing_enabled = false
		camera.limit_smoothed = false
	
	if screenshake > 0:
		randomize()
		camera.position += Vector2(clamp(screenshake, 0, 30), 0).rotated(deg2rad(rand_range(0, 360)))
		screenshake -= 1

###############################################################################

func set_hitstun(amount):
	if amount > hitstun: hitstun = amount

func set_screenshake(amount):
	if amount > screenshake: screenshake = amount
	
func get_zero_pos():
	var x = stepify(camera.get_camera_screen_center().x, 0.1)
	var y = stepify(camera.get_camera_screen_center().y, 0.1)
	return Vector2(x, y) - Vector2(1280, 720)/2
	

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		shutting_down = true
		$HTTPRequest.request(global.domain + "removegame?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(global.game_id))


func _on_request_completed(result, response_code, headers, body):
	get_tree().quit()
