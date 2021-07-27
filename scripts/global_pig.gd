extends Area2D

var lifetime
var dead = false

func _ready():
	randomize()
	position = global.get_zero_pos()
	position += Vector2(int (rand_range(50, 1230)), -50)
	randomize()
	lifetime = int (rand_range(50, 200))


func _physics_process(_delta):
	if dead: return
	
	position.y += 3
	lifetime -= 1
	for area in get_overlapping_areas(): if area.is_in_group("player"):
		expload()
	if lifetime <= 0:
		expload()


func expload():
	dead = true
	$circle_coll.disabled = false
	$coll_timer.start()
	$main_anim.play("land")


func _on_coll_timer_timeout():
	for area in get_overlapping_areas(): if area.is_in_group("player"):
		area.hurt_player(1)
	$sprites.visible = false
	$death_timer.start()


func _on_death_timer_timeout(): queue_free()
