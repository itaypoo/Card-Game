extends Area2D


var boss_hp = 100

func hurt_boss():
	boss_hp -= 1
	print(boss_hp)
	if boss_hp <= 0:
		queue_free()
