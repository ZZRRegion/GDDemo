extends Node2D
@onready var coin: Area2D = $Coin
@onready var animation_player: AnimationPlayer = $Coin/AnimationPlayer
var passed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.GameOver.connect(on_game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * GameManager.SPEED

func on_game_over()->void:
	set_process(false)
func _on_pipe_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird") and not body.is_dead:
		GameManager.emit_game_over()


func _on_coin_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird") and not passed and not body.is_dead:
		passed = true
		GameManager.GetScore.emit()
		animation_player.play("coin")
		await  animation_player.animation_finished
		coin.queue_free()


func _on_screen_exited() -> void:
	queue_free()
