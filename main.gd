extends Node
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	print(ResourceUID.create_id())
	print(ResourceUID.create_id())
	print(ResourceUID.id_to_text(22255555))

func _on_button_pressed() -> void:
	get_tree().quit(11)
	pass # Replace with function body.
