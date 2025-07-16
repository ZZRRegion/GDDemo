extends Line2D
var offset := 5.0

@export var side := -1 #-1=左侧，1=右侧
@export var player: SDPlayer

var trail_pos := Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Vector2.ZERO
	var move_dir: Vector2 = player.get_trail_direction()
	var normal := Vector2(-move_dir.y, move_dir.x).normalized()
	
	trail_pos = player.global_position + normal * offset * side
	add_point(trail_pos)
	if points.size() > 50:
		remove_point(0)
	
	
