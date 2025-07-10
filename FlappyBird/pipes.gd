extends Node2D
@onready var coin: Area2D = $Coin


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
		print("hit")
		GameManager.GameOver.emit()


func _on_coin_body_entered(body: Node2D) -> void:
	if body.is_in_group("bird"):
		GameManager.GetScore.emit()
		coin.queue_free()


func _on_screen_exited() -> void:
	queue_free()
