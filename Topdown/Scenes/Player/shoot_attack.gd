extends Node2D
@export var projectile: PackedScene
@onready var shoot_t_imer: Timer = $ShootTImer

var start_shooting: bool = false
var ready_to_shoot: bool = true
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		start_shooting = true
	if event.is_action_released("shoot"):
		start_shooting = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_t_imer.timeout.connect(on_time_out)

func on_time_out() -> void:
	ready_to_shoot = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handle_shoot()
	
func handle_shoot() -> void:
	if not start_shooting:
		return
	
	if not ready_to_shoot:
		return
	var _projectile:Projectile = projectile.instantiate() as Projectile
	get_tree().current_scene.add_child(_projectile)
	var shoot_direction = get_global_mouse_position() - global_position
	_projectile.set_up(shoot_direction)
	_projectile.global_position = global_position
	
	shoot_t_imer.start()
	ready_to_shoot = false
