extends Node2D


func _on_key_btn_pressed():
	global.play_style = "key"
	transition.fade_out("res://scenes/input_names.tscn")


func _on_app_btn_pressed():
	global.play_style = "app"
	transition.fade_out("res://scenes/server_connection.tscn")
