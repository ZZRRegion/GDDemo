class_name  SDPlayer
extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var spray_trail: CPUParticles2D = $Particles/SprayTrail
@onready var particles: Node2D = $Particles

# 物理相关属性
@export var max_speed := 850.0  # 玩家最大移动速度
@export var gravity := 800.0	# 下坡时的重力加速度
@export var friction := 100.0	# 地面擦力系数
@export var control := 500.0	# 转向控制灵敏度

# 运动状态
var is_player_steering := false	#是否在控制方向
var move_direction := Vector2.RIGHT	# 当前移动方向的向量

func _process(_delta: float) -> void:
	_update_visual()
func  _physics_process(delta: float) -> void:
	if is_player_steering:
		_update_direction()
	_update_velocity(delta)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		is_player_steering = true
	elif event.is_action_released("move_left"):
		is_player_steering = false
		
#更新有视觉元素
func _update_visual() -> void:
	particles.rotation = move_direction.angle()
	#更新角色精灵帧
	_update_sprite_frame()
	#更新粒子效果
	
#更新精灵，根据方向角度计算显示帧（0-5）
func _update_sprite_frame() -> void:
	var frame_index = max(0, move_direction.dot(Vector2.DOWN)) * 3
	
	if move_direction.dot(Vector2.LEFT):
		frame_index += 3
	sprite_2d.frame = int(frame_index) % 6
	
# 更新方向
func _update_direction():
	var mouse_pos := get_global_mouse_position()
	var target_dir := (mouse_pos - global_position).normalized()
	
	move_direction = target_dir

# 更新移动
func _update_velocity(delta):
	var downhill_dot = move_direction.dot(Vector2.DOWN)
	var downhill_multiplier = sign(downhill_dot) * sqrt(abs(downhill_dot))
	var friction_multiplier = 1.0 - max(0.0, downhill_dot)
	
	# 计算坡度的速度数
	var max_speed_multiplier = (downhill_dot + 1.0) / 2.0
	var speed := velocity.length()
	var current_max_speed = max_speed * max_speed_multiplier
	speed += gravity * downhill_multiplier * delta
	
	#限制速度
	speed = move_toward(speed, 0, friction_multiplier * friction * delta)
	speed = clamp(speed, -current_max_speed, current_max_speed)
	
	velocity = velocity.move_toward(move_direction * speed, control * delta)

func get_trail_direction() -> Vector2:
	return move_direction.normalized()
