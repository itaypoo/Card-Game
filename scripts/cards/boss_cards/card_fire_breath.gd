extends Area2D

onready var coll_shape = $coll_shape

var start_pos = Vector2.ZERO

func _ready():
	start_pos = position
	
	
func _physics_process(_delta):
	position = start_pos
	position += Vector2(coll_shape.shape.extents.x, 0).rotated((global.player_pos - global_position).angle())
	rotation = (global.player_pos - global_position).angle()
	for area in get_overlapping_areas():
		if area.is_in_group("player"):
			area.hurt_player(1)
