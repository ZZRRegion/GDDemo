extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wing_sound: AudioStreamPlayer = $WingSound
@onready var hit_sound: AudioStreamPlayer = $HitSound
@onready var point_sound: AudioStreamPlayer = $PointSound
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var rot_degree :float = 0

var is_dead :bool = false
func _ready() -> void:
	GameManager.GameOver.connect(on_game_over)
	GameManager.GetScore.connect(on_get_score)
	
func on_game_over()->void:
	is_dead = true
	animated_sprite_2d.stop()
	hit_sound.play()
	cpu_particles_2d.emitting = false
	
func on_get_score() ->void:
	point_sound.play()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += GameManager.GRAVITY * delta

	# Handle jump.
	if not is_dead:
		if Input.is_action_just_pressed("fly"):
			velocity.y = GameManager.JUMP_VELOCITY
			wing_sound.play()
		rot_degree = clampf(-30 * velocity.y / GameManager.JUMP_VELOCITY, -30, 30)
		rotation_degrees = rot_degree
	else:
		rotation_degrees = 90
	move_and_slide()
