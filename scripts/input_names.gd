extends Node2D

onready var bubble = $dialogue_bubble
var is_done = false
var pname

var random_facts = [
	"love eating pineapples!",
	"have fought a bear in a 1v1 battle!",
	"have 7 cats!",
	"can eat a Bigmac in less than 30 seconds!",
	"have a plan to rule the world someday!",
	"love destroying nature!",
	"love Jigglypuff!",
	"love eating SPAM",
	"have a poopy buthole",
	"are a pro Esports player!",
	"have beaten the ender dragon at least 5 times!",
	"love playing guitar, but only play the same song over and over again!",
	"are the founder of a famous sock company!",
	"don't pay their taxes!",
	"belive the earth is flat!",
	"have a crush on Tinky Winky from Teletubbies!",
	"know Barack Obama on a personal level!",
	"are the singer of a famous rock band!"
]

var current_player = 1
var dialogue_stage = 0

func _ready(): 
	next_stage()
	transition.start_music("res://sound/music/music_big_stage.mp3")
	global.player_scores = [0, 0, 0, 0]

func _on_dialogue_bubble_dialogue_ended():
	next_stage()

func _on_done_btn_pressed():
	pname = $name_textbox/textbox.text.replace("\n", "")
	if pname.length() < 2:
		pname == str("P", current_player)
	global.player_names[current_player-1] = pname
	
	$name_textbox.visible = false
	next_stage()

func next_stage():
	dialogue_stage += 1
	match dialogue_stage:
		1:
			$cosmetics/player_cutscene.leave()
			$name_textbox/textbox.text = ""
			$name_textbox.visible = true
			$name_textbox/label.text = str("Enter P", current_player, " Name:")
		2:
			var num_to_words
			if current_player == 1: num_to_words = "first"
			elif current_player == 2: num_to_words = "second"
			elif current_player == 3: num_to_words = "third"
			elif current_player == 4: num_to_words = "forth"
			bubble.dialogue_start(str("Please welcome our ", num_to_words, " contestent, ", global.player_names[current_player-1], "!"))
		3:
			$cosmetics/player_cutscene.join(current_player)
			randomize()
			$crowd.pitch_scale = rand_range(0.8, 1.2)
			$crowd.play()
			randomize()
			var hight : float = int(rand_range(000, 60))
			hight = hight / 10
			randomize()
			var age =  int(rand_range(0, 40))
			randomize()
			var rfact = random_facts[int(rand_range(0, random_facts.size()))]
			bubble.dialogue_start(str(global.player_names[current_player-1], " is ", hight, " meters tall at the age of ", age, ", and they ", rfact))
		_:
			if current_player >= 4:
				if not is_done:
					bubble.dialogue_start(str("Our first player will be ", global.player_names[0], ". Let's find out if they will be able to overcome the other player's traps and defeat the boss!"))
					is_done = true
				else:
					global.current_player == 1
					transition.fade_out("res://scenes/card_inputer.tscn")
					return
			else:
				current_player += 1
				dialogue_stage = 0
				next_stage()

