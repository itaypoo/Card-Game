extends Node2D

onready var p1_label = $p1/p1_label
onready var p2_label = $p2/p2_label
onready var p3_label = $p3/p3_label
onready var p4_label = $p4/p4_label

var p1_score = 0
var p2_score = 0
var p3_score = 0
var p4_score = 0

var p1_final_y = 0
var p2_final_y = 0
var p3_final_y = 0
var p4_final_y = 0

var time = 0
var max_score = 600
var max_y = 650

var speed_array = [3, 3, 3, 3]
var dialogue_stage = 0

func _ready():
	transition.start_music("res://sound/music/music_dramatic_buildup.mp3")
	# Vars:
	p1_score = global.player_scores[0]
	p2_score = global.player_scores[1]
	p3_score = global.player_scores[2]
	p4_score = global.player_scores[3]
	# Text:
	p1_label.text = str(global.player_names[0], ": " , int(p1_score), "pts")
	p2_label.text = str(global.player_names[1], ": " , int(p2_score), "pts")
	p3_label.text = str(global.player_names[2], ": " , int(p3_score), "pts")
	p4_label.text = str(global.player_names[3], ": " , int(p4_score), "pts")
	# Locations:
	$p1.position = Vector2(320-320/2, 720-105)
	$p2.position = Vector2(320*2-320/2, 720-105)
	$p3.position = Vector2(320*3-320/2, 720-105)
	$p4.position = Vector2(320*4-320/2, 720-105)
	# Final Locations:
	if max_score > 0:
		p1_final_y = 720 - (p1_score * max_y/max_score)
		p2_final_y = 720 - (p2_score * max_y/max_score)
		p3_final_y = 720 - (p3_score * max_y/max_score)
		p4_final_y = 720 - (p4_score * max_y/max_score)

var adj_list = [
	"EPIC!",
	"amazing!",
	"a joy to watch!",
	"pretty embarrassing",
	"wonderfull!",
	"a great fight!",
	"good!",
	"something!",
	"noice!",
	"boring!",
	"the best fight i've ever seen!"
]

func _physics_process(_delta):
	if not max_score > 0: return
	
	time += 1
	if time >= 60:
		if p1_final_y <= $p1.position.y:
			$p1.position.y -= speed_array[0]
		elif speed_array[0] > 0:
			speed_array[0] -= 0.1
			$p1.position.y -= speed_array[0]
		else:
			p1_label.visible = true
		if p2_final_y <= $p2.position.y:
			$p2.position.y -= speed_array[1]
		elif speed_array[1] > 0:
			speed_array[1] -= 0.1
			$p2.position.y -= speed_array[1]
		else:
			p2_label.visible = true
		if p3_final_y <= $p3.position.y:
			$p3.position.y -= speed_array[2]
		elif speed_array[2] > 0:
			speed_array[2] -= 0.1
			$p3.position.y -= speed_array[2]
		else:
			p3_label.visible = true
		if p4_final_y <= $p4.position.y:
			$p4.position.y -= speed_array[3]
		elif speed_array[3] > 0:
			speed_array[3] -= 0.1
			$p4.position.y -= speed_array[3]
		else:
			p4_label.visible = true
	
	if (speed_array[0] + speed_array[1] + speed_array[2] + speed_array[3]) < 0.1:
		if dialogue_stage == 0:
			dialogue_stage += 1
			$confetti.emitting = true
			$cheer.play()
			$horn.play()
			randomize()
			$dialogue_bubble.dialogue_start(str( "Wow! that was ", adj_list[int(rand_range(0, adj_list.size()))]))

func get_winning_player():
	var biggest_score = 0
	var biggest_id
	for i in range(0, 4):
		if global.player_scores[i] > biggest_score:
			biggest_score = global.player_scores[i]
			biggest_id = i
	
	return biggest_id

func _on_dialogue_bubble_dialogue_ended():
	match dialogue_stage:
		1:
			$dialogue_bubble.dialogue_start(str( global.player_names[get_winning_player()], " is in the lead with ", global.player_scores[get_winning_player()], " points!" ))
			dialogue_stage += 1
		2:
			if global.current_player == 4: 
				print("Game over. Winner = ", global.player_names[get_winning_player()])
				queue_free()
			else:
				global.current_player += 1
				$dialogue_bubble.dialogue_start(str( "Our next contestent will be ", global.player_names[global.current_player - 1], ". Good luck!" ))
				dialogue_stage += 1
		3: 
			transition.fade_out("res://scenes/card_inputer.tscn")
