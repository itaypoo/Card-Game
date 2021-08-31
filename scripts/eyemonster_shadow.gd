extends Area2D

var delay = 1.2

func _ready():
	yield(get_tree().create_timer(delay), "timeout")
	$ready_anim.play("ready")

func _physics_process(_delta):
	for area in get_overlapping_areas():
		if area.is_in_group("player"): area.hurt_player(1)

func _on_ready_anim_animation_finished(_anim_name): queue_free()
