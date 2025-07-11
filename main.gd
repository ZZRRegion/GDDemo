extends Node
@onready var enery: CharacterBody2D = $Enery
@onready var player: Area2D = $Player
const SPEED: int = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		enery.position += Vector2.LEFT * delta * SPEED
	elif Input.is_action_pressed("move_right"):
		enery.position += Vector2.RIGHT * delta * SPEED
		
	if Input.is_action_pressed("move_up"):
		player.position += Vector2.LEFT * delta * SPEED
	elif Input.is_action_pressed("move_down"):
		player.position += Vector2.RIGHT * delta * SPEED
	pass


func _on_player_body_entered(body: Node2D) -> void:
	print("player->" + str(body))
