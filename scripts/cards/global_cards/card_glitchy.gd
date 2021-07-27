extends Node2D

onready var back_timer = $back_timer
onready var randtp_timer = $randtp_timer
onready var pause_timer = $pause_timer

var old_pos = Vector2.ZERO

var rng = Vector2(5, 15)

func _ready():
	randomize()
	back_timer.wait_time = rand_range(rng.x, rng.y)
	randomize()
	randtp_timer.wait_time = rand_range(rng.x, rng.y)
	randomize()
	pause_timer.wait_time = rand_range(rng.x, rng.y)

func _physics_process(_delta):
	position = global.get_zero_pos()
	
func _on_back_timer_timeout():
	get_tree().call_group("player", "set_pos", old_pos)
	randomize()
	back_timer.wait_time = rand_range(rng.x, rng.y)
	$glitch_anim.play("glitch")

func _on_oldpos_timer_timeout():
	old_pos = global.player_pos

func _on_randtp_timer_timeout():
	var random_pos = Vector2(0,0)
	randomize()
	random_pos.x = int(rand_range(-150, 150))
	randomize()
	random_pos.y = int(rand_range(-150, 150))
	get_tree().call_group("player", "set_pos", global.player_pos + random_pos)
	$glitch_anim.play("glitch")
	randomize()
	randtp_timer.wait_time = rand_range(rng.x, rng.y)

func _on_pause_timer_timeout():
	global.set_hitstun(30)
	$glitch_anim.play("glitch")
	randomize()
	$fake_error.emitting = true
	pause_timer.wait_time = rand_range(rng.x, rng.y)
