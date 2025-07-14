extends Node2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: SDPlayer = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		camera_2d.global_position = player.global_position
	print("player==", player.global_position)
