@tool
extends Node

func _ready() -> void:
	DisplayServer.window_set_title("hello")
	pass

func _on_button_pressed() -> void:
	DisplayServer.beep()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	DisplayServer.dialog_input_text("title", "desc", "萨芬", test)
	pass # Replace with function body.

func test(txt) -> void:
	print(txt)
