
extends Node2D

onready var label = $label

var text = ""
var letter = 0

signal dialogue_ended

func _ready():
	visible = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("skip_text"):
		$end_timer.wait_time = 1.5
		label.text = text
		letter = text.length()

func dialogue_start(text = "Default text"):
	visible = true
	$timer.start()
	label.text = ""
	self.text = text
	letter = 0

func connect_to_signal(node):
	connect("dialogue_ended", node, "signal_handler")
func signal_handler():
	pass

func _on_timer_timeout():
	visible = true
	if letter >= text.length():
		$end_timer.start()
		$timer.stop()
		return
	label.text += text[letter]
	letter += 1

func _on_end_timer_timeout():
	$end_timer.wait_time = 4
	emit_signal("dialogue_ended")
	visible = false
