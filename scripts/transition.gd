extends Node2D

export (String) var next_scene

func fade_out(next_scene):
	self.next_scene = next_scene 
	$anim.play("fade_out")


func _on_anim_animation_finished(anim_name):
	if anim_name == "fade_out":
		if next_scene == "res://scenes/world.tscn": 
			global.ingame = true
			global.camera.position = Vector2(560,540)
		else: global.ingame = false
		get_tree().change_scene(next_scene)
		$anim.play("fade_in")
