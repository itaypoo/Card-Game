extends Area2D

export (int) var move_speed = 5

func _physics_process(_delta):
	if Input.is_action_pressed("player_up"): position.y -= move_speed
	elif Input.is_action_pressed("player_down"): position.y += move_speed
	if Input.is_action_pressed("player_left"): position.x -= move_speed
	elif Input.is_action_pressed("player_right"): position.x += move_speed
