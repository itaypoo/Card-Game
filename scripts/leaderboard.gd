extends Node2D

var p1_score = 0
var p2_score = 0
var p3_score = 0
var p4_score = 0

func _ready():
	# Text:
	$p1/p1_label.text = "Score : " + str(p1_score)
	$p2/p2_label.text = "Score : " + str(p2_score)
	$p3/p3_label.text = "Score : " + str(p3_score)
	$p4/p4_label.text = "Score : " + str(p4_score)
	#Locations:
	$p1.position = Vector2(320-320/2, 720-105)
	$p2.position = Vector2(320*2-320/2, 720-105)
	$p3.position = Vector2(320*3-320/2, 720-105)
	$p4.position = Vector2(320*4-320/2, 720-105)
