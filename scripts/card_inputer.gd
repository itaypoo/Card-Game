extends Node2D

var card_tex = preload("res://scenes/sprite_card_generator.tscn")

onready var text = $text
var input = 0
var cards_spawned = 0

var request_cd = 0
var request_last_time = -1
func _ready():
	transition.start_music("res://sound/music/music_in_space.mp3")
	global.active_cards = []
	var card = 0
	$float_player/sprites_player/leg_left.frame = global.current_player - 1
	$float_player/sprites_player/leg_right.frame = global.current_player - 1
	$float_player/sprites_player/body.frame = global.current_player - 1
	$float_player/sprites_player/head.frame = global.current_player - 1
	$float_player/sprites_player/hnad_sheet.frame = global.current_player - 1
	$float_player/sprites_player/hnad_sheet2.frame = global.current_player - 1
	$HTTPRequest_game.request(global.domain + "enablecards?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(global.game_id))

func _physics_process(_delta):
	if request_cd >= 30:
		request_cd = 0
		if $HTTPRequest_card.get_http_client_status() == HTTPClient.STATUS_DISCONNECTED:
			$HTTPRequest_card.request(global.domain + "getcards?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(global.game_id))
	else:
		request_cd+=1

func _input(event):
	if cards_spawned >= 4: return
	
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
			elif Input.is_action_just_pressed("back"):
				num = null
				input = 0
				text.text = str("Insert Card >> ", input)
			
			if num:
				input *= 10
				input += num
			text.text = str("Insert Card >> ", input)
			
			if Input.is_action_just_pressed("enter"): 
				if global.card_list.has(input):
					spawn_card(input)
				else:
					text.text = "Invalid Card ID"
				input = 0

func spawn_card(id):
	if cards_spawned >= 4: return
	if global.active_cards.has(id):
		text.text = "You cannot enter the same card twice."
		return
	
	get_tree().call_group("world", "added_card", id)
	global.active_cards.append(id)
	text.text = "Added Card"
	
	cards_spawned += 1
	var card_inst = card_tex.instance()
	card_inst.card_id = id
	card_inst.position = Vector2((320 * cards_spawned) - 160, 360)
	card_inst.does_spawn_anim = true
	add_child(card_inst)
	
	randomize()
	$sfx_cardflip.pitch_scale = rand_range(0.8, 1.2)
	$sfx_cardflip.play()
	
	if cards_spawned >= 4: 
		$ruready_anim.play("ruready")
		$float_player/player_anim.play("fly_away")

func _on_ruready_anim_animation_finished(anim_name):
	transition.fade_out("res://scenes/world.tscn")


func _on_player_anim_animation_finished(anim_name):
	if anim_name == "ready": $float_player/player_anim.play("idle")

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse(body.get_string_from_utf8())
		for card in json.result.get("cards"):
			if card.get("time") >= request_last_time:
				spawn_card(int(card.get("cardID")))
		request_last_time = json.result.get("current_time")
