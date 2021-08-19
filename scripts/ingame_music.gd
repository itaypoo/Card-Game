extends Node2D

var songs = ["res://sound/ingame-music/coconut_gun.mp3", "res://sound/ingame-music/electro_fight.mp3", "res://sound/ingame-music/funky_groove.mp3", "res://sound/ingame-music/hisgoooooz.mp3", "res://sound/ingame-music/tetris_wannabe.mp3", "res://sound/ingame-music/victory_royale.mp3", "res://sound/ingame-music/wholesome.mp3"]
var names = ["Coconut Gun", "Electro Fight", "Funky Groove", "Hishgoooooooz", "Tetris Wannabe", "Victory Royale", "Wholesome"]

func _ready():
	randomize()
	var songid = int(rand_range(0, 0))
	transition.start_music(songs[songid])
	$label.text = str("Now Playing: ", names[songid])

func _on_fadeout_animation_finished(anim_name):
	queue_free()
