extends CharacterBody2D
@export var move_speed: float = 50
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@export var bullet_scene:PackedScene
var is_game_over: bool = false
@onready var fire: AudioStreamPlayer = $Fire
@onready var gameover: AudioStreamPlayer = $GameOver
@onready var running_sound: AudioStreamPlayer = $RunningSound

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		running_sound.stop()
	elif not running_sound.playing:
		running_sound.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_game_over:
		var vec: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = vec * move_speed
		if vec == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		move_and_slide()

func game_over() -> void:
	if not is_game_over:
		animator.play("game_over")
		is_game_over = true
		get_tree().current_scene.show_game_over()
		gameover.play()
		$reload.start()


func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	fire.play()
	var bullet = bullet_scene.instantiate()
	bullet.position = position + Vector2(6, 6)
	get_tree().current_scene.add_child(bullet)


func _on_reload_timeout() -> void:
	get_tree().reload_current_scene()
