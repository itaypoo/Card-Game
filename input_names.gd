extends Node2D

onready var bubble = $dialogue_bubble

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
	"are a pro Minecraft player!",
	"have beaten the ender dragon at least 5 times!",
	"love playing guitar, but only play the same song over and over again!",
	"are the founder of a famous sock company!",
	"don't pay their taxes!",
	"belive the earth is flat!"
]

var current_player = 1
var dialogue_stage = 0

func _ready(): next_stage()

func _on_dialogue_bubble_dialogue_ended():
	next_stage()

func _on_done_btn_pressed():
	global.player_names[current_player-1] = $name_textbox/textbox.text
	$name_textbox.visible = false
	next_stage()

func next_stage():
	dialogue_stage += 1
	match dialogue_stage:
		1:
			$name_textbox/textbox.text = ""
			$name_textbox.visible = true
			$name_textbox/label.text = str("Enter P", current_player, " Name:")
		2:
			var num_to_words
			if current_player == 1: num_to_words = "first"
			elif current_player == 2: num_to_words = "second"
			elif current_player == 3: num_to_words = "third"
			elif current_player == 4: num_to_words = "forth"
			print(current_player)
			bubble.dialogue_start(str("Please welcome our ", num_to_words, " contestent, ", global.player_names[current_player-1], "!"))
		3:
			randomize()
			var hight : float = int(rand_range(50, 400))
			hight = hight / 100
			randomize()
			var age =  int(rand_range(0, 40))
			randomize()
			var rfact = random_facts[int(rand_range(0, random_facts.size()))]
			bubble.dialogue_start(str(global.player_names[current_player-1], " is ", hight, " meters tall at the age of ", age, ", and they ", rfact))
		_:
			if current_player >= 4: 
				global.current_player == 1
				transition.fade_out("res://scenes/card_inputer.tscn")
				return
			current_player += 1
			dialogue_stage = 0
			next_stage()

