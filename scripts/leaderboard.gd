extends Node2D

var p1_label
var p2_label
var p3_label
var p4_label

var p1_score = 10
var p2_score = 7
var p3_score = 3
var p4_score = 5

var p1_final_y = 0
var p2_final_y = 0
var p3_final_y = 0
var p4_final_y = 0

var time = 0
var max_score = 0
var max_y = 680


func _ready():
	# Vars:
	p1_label = $p1/p1_label
	p2_label = $p2/p2_label
	p3_label = $p3/p3_label
	p4_label = $p4/p4_label
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
	set_max_score(p1_score, p2_score, p3_score, p4_score)
	if max_score > 0:
		p1_final_y = 720 - (p1_score * max_y/max_score)
		$p1/Tween.interpolate_property($p1, "position", $p1.position, Vector2($p1.position.x, p1_final_y), 2.0 * (p1_score/3), Tween.TRANS_SINE, Tween.EASE_OUT)
		p2_final_y = 720 - (p2_score * max_y/max_score)
		$p2/Tween.interpolate_property($p2, "position", $p2.position, Vector2($p2.position.x, p2_final_y), 2.0 * (p2_score/3), Tween.TRANS_SINE, Tween.EASE_OUT)
		p3_final_y = 720 - (p3_score * max_y/max_score)
		$p3/Tween.interpolate_property($p3, "position", $p3.position, Vector2($p3.position.x, p3_final_y), 2.0 * (p3_score/3), Tween.TRANS_SINE, Tween.EASE_OUT)
		p4_final_y = 720 - (p4_score * max_y/max_score)
		$p4/Tween.interpolate_property($p4, "position", $p4.position, Vector2($p4.position.x, p4_final_y), 2.0 * (p4_score/3), Tween.TRANS_SINE, Tween.EASE_OUT)


func _physics_process(_delta):
	if max_score > 0:
		time += 1
		if time == 60:
			$p1/Tween.start()
			$p2/Tween.start()
			$p3/Tween.start()
			$p4/Tween.start()
#			if p1_final_y <= $p1.position.y:
#				$p1.position.y -= 3
#			else:
#				p1_label.visible = true
#			if p2_final_y <= $p2.position.y:
#				$p2.position.y -= 3
#			else:
#				p2_label.visible = true
#			if p3_final_y <= $p3.position.y:
#				$p3.position.y -= 3
#			else:
#				p3_label.visible = true
#			if p4_final_y <= $p4.position.y:
#				$p4.position.y -= 3
#			else:
#				p4_label.visible = true
	
func set_max_score(score1, score2, score3, score4):
	max_score = max(score1, score2)
	max_score = max(max_score, score3)
	max_score = max(max_score, score4)
