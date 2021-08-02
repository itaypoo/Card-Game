extends Node2D

onready var label = $label

var text = ""
var letter = 0

signal dialogue_ended

func _ready():
	dialogue_start("Hello my name is yaron and i am a balon. Nice too meet you, do you want to see my pee pee?")
	visible = false

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
	emit_signal("dialogue_ended")
	visible = false
