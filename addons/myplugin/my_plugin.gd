@tool
extends EditorPlugin

var button

func _enter_tree() -> void:
	button = Button.new()
	button.text = "显示当前时间"
	button.pressed.connect(_on_button_pressed)
	add_control_to_container(CONTAINER_PROJECT_SETTING_TAB_LEFT, button)
	
func _exit_tree() -> void:
	remove_control_from_container(CONTAINER_PROJECT_SETTING_TAB_LEFT, button)
	button.queue_free()
	button = null
	
func _on_button_pressed():
	var now = Time.get_datetime_string_from_system(false, false)
	print(now)
