class_name CameraFollow

extends Camera2D

@export var target:Node2D = null
@export var smooth_speed: float = 8.0
@export var follow_x: bool = true
@export var start_follow_y: float = 50
@export var follow_offset: Vector2 = Vector2(0, 220)

var _base_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target:
		_base_position = target.global_position + follow_offset
		global_position = _base_position

func _physics_process(delta: float) -> void:
	if not target: return
	
	var target_pos = target.global_position
	
	#y轴的跟随逻辑
	var final_y = _base_position.y
	if target_pos.y > start_follow_y:
		var t = clamp((target_pos.y - start_follow_y) / 100.0, 0.0, 1.0)
		final_y = lerp(_base_position.y, target_pos.y + follow_offset.y, t * t)
		
	#保持X轴不变
	var final_x = global_position.x
	
	#平滑移动
	global_position = global_position.lerp(
		Vector2(final_x, final_y),
		smooth_speed * delta
	)
	
