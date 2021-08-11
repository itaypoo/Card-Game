extends Node2D

export (String) var next_scene

func fade_out(next_scene):
	self.next_scene = next_scene 
	$anim.play("fade_out")
	$music_fade.interpolate_property($music_player, "volume_db", 0, -50, 0.3)
	$music_fade.start()

func _on_anim_animation_finished(anim_name):
	if anim_name == "fade_out":
		if next_scene == "res://scenes/world.tscn": 
			global.camera.position = Vector2(560,540)
		global.ingame = false
		get_tree().change_scene(next_scene)
		$anim.play("fade_in")

func start_music(path, volume = 0):
	print("Now playing - '", path, "'")
	var song = load(path)
	$music_player.stream = song
	$music_player.play()
	$music_player.volume_db = -50
	$music_fade.interpolate_property($music_player, "volume_db", -50, 0, 0.5)
	$music_fade.start()
