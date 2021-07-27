extends Area2D

func _ready():
	randomize()
	position = global.get_zero_pos()
	position.x += rand_range(100, 1180)
	
func _physics_process(_delta):
	position.y = global.get_zero_pos().y

func _on_anim_animation_finished(anim_name):
	if anim_name == "load":
		global.set_screenshake(10)
		$anim.play("activate")
	else: queue_free()

func _on_gloabal__lightning_area_entered(area):
	if area.is_in_group("player"): area.hurt_player(1)
