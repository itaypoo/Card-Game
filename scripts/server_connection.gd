extends Node2D

var waiting_for_devices = false

var waiting_cd = 0

enum request_types{AVAILABLE_GAME, ADD_GAME, REMOVE_GAME, WAITING_PHONES, ALLOWED_PHONES}

var phone_scene = preload("res://scenes/phone.tscn")

func _ready():
	$HTTPRequest.connect("request_completed", self, "_on_request_completed", [request_types.AVAILABLE_GAME])
	$HTTPRequest.request(global.domain + "availablegame?" + "user=" + global.user + "&pass=" + global.password)

func _physics_process(_delta):
	if waiting_for_devices and not global.shutting_down:
		if waiting_cd < 60:
			waiting_cd+=1
		else:
			waiting_cd = 0
			reconnect(request_types.WAITING_PHONES)
			$HTTPRequest.request(global.domain + "waitingphones?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(global.game_id))


func _on_request_completed(result, response_code, headers, body, request_type):
	if response_code == 200:
		match request_type:
			request_types.AVAILABLE_GAME:
				available_game(JSON.parse(body.get_string_from_utf8()))
			request_types.ADD_GAME:
				game_added()
			request_types.REMOVE_GAME:
				return
			request_types.WAITING_PHONES:
				waiting_phones(JSON.parse(body.get_string_from_utf8()))
			request_types.ADD_PHONE:
				print("add phone")
			request_types.REMOVE_PHONE:
				print("remove phone")
			_:
				return

func available_game(json):
	if typeof(json.result) == 2 or typeof(json.result) == 3:
		var id = int(json.result)
		if id >= 1000 and id <= 9999:
			global.game_id = int(json.result)
			reconnect(request_types.ADD_GAME)
			$HTTPRequest.request(global.domain + "addgame?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(json.result))
	
func waiting_phones(json):
	var old_phones = []
	# Get already added phones
	for node in $connected_devices/phones/waiting_phones.get_children():
		if not node.name == "title":
			for phone in json.result:
				var phone_name = phone.get("name").replace("-", " ").replace(" Plus", "+")
				if (phone_name == node.get_node("phone_name").text):
					old_phones.append(node.get_node("phone_name").text)
	# Add new phones
	if json.result.size() > 0:
		$connected_devices/phones/waiting_phones.visible = true
	else:
		$connected_devices/phones/waiting_phones.visible = false
	for phone in json.result:
		var phone_name = phone.get("name").replace("-", " ").replace(" Plus", "+")
		if not old_phones.has(phone_name):
			var phone_instance = phone_scene.instance()
			phone_instance.get_node("phone_name").text = phone_name
			$connected_devices/phones/waiting_phones.add_child(phone_instance)
	

func game_added():
	waiting_for_devices = true
	$loading_label.visible = false
	$id.visible = true
	$id/id_label.text = str(global.game_id)
	$connected_devices.visible = true
	reconnect(request_types.WAITING_PHONES)
	$HTTPRequest.request(global.domain + "waitingphones?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(global.game_id))
	
func reconnect(request_type):
	$HTTPRequest.disconnect("request_completed", self, "_on_request_completed")
	$HTTPRequest.connect("request_completed", self, "_on_request_completed", [request_type])


func _on_start_pressed():
	if not $id/start.disabled:
		$id/start.disabled = true
		$id/HTTPRequest_start.request(global.domain + "allowedphones?" + "user=" + global.user + "&pass=" + global.password + "&id=" + str(global.game_id))


func _on_start_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if (json.result.size() > 0):
		$id/status.visible = false
		#transition.fade_out("res://scenes/card_inputer.tscn")
		transition.fade_out("res://scenes/input_names.tscn")
	else:
		$id/status.visible = true
	$id/start.disabled = false
