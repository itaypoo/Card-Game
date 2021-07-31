extends Node2D

export(int) var card_id
export(bool) var does_spawn_anim = false

func _ready():
	$id_text.text = str(card_id)
	$title.text = card_titles[card_id]
	$type_icon.frame = (card_id % 10) - 2
	
	if does_spawn_anim: 
		$spawn_anim.play("spawn")


var card_titles = {
	12: "Boss spawns bees",
	22: "Boss breaths fire",
	32: "Boss shoots lazers",
	42: "Boss shoots rockets",
	52: "Boss shoots spider webs",
	62: "Boss moves slow",
	72: "Boss moves fast",
	82: "Boss has more health",
	92: "Boss has less health",
	
	13: "Player is drunk",
	23: "Player is super fast",
	33: "Player is slippery",
	43: "Player has more health",
	53: "Player has a shotgun",
	63: "Player has a machine gun",
	73: "Player has a sniper rifle",
	83: "Player has aiming bullets",
	
	14: "Random pictures of goats pop up",
	24: "Raining exploading pigs",
	34: "The screen is on drugs",
	44: "The screen is pixelated",
	54: "There's a wind storm",
	64: "There's a thunder storm",
	74: "The game is glitchy",
	84: "Player has clones"
}
