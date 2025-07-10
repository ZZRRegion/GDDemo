extends Node2D
const PIPES : PackedScene = preload("res://FlappyBird/Pipes.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().title = "小鸟出动 @zzr"
	GameManager.GameOver.connect(on_game_over)
	new_pipes()
	pass # Replace with function body.

func on_game_over()->void:
	$Timer.stop()
	
func new_pipes():
	var pipes = PIPES.instantiate()
	var pos_y = randf_range($SpawnPoint.position.y - 180, $SpawnPoint.position.y + 180)
	
	pipes.global_position.x = $SpawnPoint.position.x
	pipes.global_position.y = pos_y
	add_child(pipes)

func _on_timer_timeout() -> void:
	new_pipes()
