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
var max_score = 500
var max_y = 650

var speed_array = [3, 3, 3, 3]

func _ready():
	# Vars:
	p1_score = global.player_scores[0]
	p2_score = global.player_scores[1]
	p3_score = global.player_scores[2]
	p4_score = global.player_scores[3]
	# Text:
	p1_label.text = "Score : " + str(p1_score)
	p2_label.text = "Score : " + str(p2_score)
	p3_label.text = "Score : " + str(p3_score)
	p4_label.text = "Score : " + str(p4_score)
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


func _physics_process(_delta):
	if max_score > 0:
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

