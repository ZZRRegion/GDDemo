extends Control
@export var game_scene : PackedScene
@onready var button: Button = $Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(on_pressed)

func on_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)
