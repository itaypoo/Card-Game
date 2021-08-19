extends HBoxContainer

var state = states.WAITING

enum states{WAITING, ALLOWED}
enum request_types{ADD_PHONE, DENY_PHONE, REMOVE_PHONE}

var phone_scene

func _ready():
	phone_scene = load("res://scenes/phone.tscn")

func allowed():
	$allow.queue_free()
	state = states.ALLOWED
	
func _on_request_completed(result, response_code, headers, body, request_type):
	if response_code == 200:
		match request_type:
			request_types.ADD_PHONE:
				var amount = 0
				for node in get_node("../").get_children():
					if not node.name == "title" and not node == self: amount+=1
				if amount == 0: get_node("../").visible = false
				move_to_allowed()
			request_types.DENY_PHONE:
				var amount = 0
				for node in get_node("../").get_children():
					if not node.name == "title" and not node == self: amount+=1
				if amount == 0: get_node("../").visible = false
				queue_free()
			request_types.REMOVE_PHONE:
				var amount = 0
				for node in get_node("../").get_children():
					if not node.name == "title" and not node == self: amount+=1
				if amount == 0: get_node("../").visible = false
				queue_free()
			_:
				return

func move_to_allowed():
	var phone_instance = phone_scene.instance()
	phone_instance.get_node("phone_name").text = $phone_name.text
	phone_instance.allowed()
	get_node("../../").get_node("allowed_phones").add_child(phone_instance)
	get_node("../../").get_node("allowed_phones").visible = true
	queue_free()

func _on_allow_button_down():
	reconnect(request_types.ADD_PHONE)
	$HTTPRequest.request(global.domain + "addphone?" +
	 "user=" + global.user +
	 "&pass=" + global.password +
	 "&id=" + str(global.game_id) +
	 "&name=" + get_node("phone_name").text.replace("+", " Plus").replace(" ", "-").replace("?", "%3F"))


func _on_deny_button_down():
	print(state)
	if state == states.WAITING:
		reconnect(request_types.DENY_PHONE)
		$HTTPRequest.request(global.domain + "denyphone?" + 
		"user=" + global.user + 
		"&pass=" + global.password + 
		"&id=" + str(global.game_id) + 
		"&name=" + get_node("phone_name").text.replace("+", " Plus").replace(" ", "-").replace("?", "%3F"))
	else:
		reconnect(request_types.REMOVE_PHONE)
		$HTTPRequest.request(global.domain + "removephone?" + 
		"user=" + global.user + 
		"&pass=" + global.password + 
		"&id=" + str(global.game_id) + 
		"&name=" + get_node("phone_name").text.replace("+", " Plus").replace(" ", "-").replace("?", "%3F"))


func reconnect(request_type):
	$HTTPRequest.disconnect("request_completed", self, "_on_request_completed")
	$HTTPRequest.connect("request_completed", self, "_on_request_completed", [request_type])
