extends Node2D
@export var slime_scene: PackedScene
@onready var timer: Timer = $Timer
@export var score: int = 0
@onready var label: Label = $CanvasLayer/Label
@onready var game_over: Label = $CanvasLayer/GameOver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.wait_time -= 0.2 * delta
	timer.wait_time = clamp(timer.wait_time, 1, 3)
	label.text = "score:" + str(score)


func _on_timer_timeout() -> void:
	var slime_node = slime_scene.instantiate()
	slime_node.position = Vector2(260, randf_range(50, 115))
	get_tree().current_scene.add_child(slime_node)

func show_game_over() -> void:
	game_over.show()
