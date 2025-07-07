extends Control

var count_time : int = 60 * 60 * 24
const  game_data_path = "user://game.json"
func save_game_data(file_path: String, data:Dictionary) -> void:
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	file.store_string(json_string)
	file.close()
	
func load_game_data(file_path: String) -> Dictionary:
	if !FileAccess.file_exists(file_path):
		return {}
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	var parse_result = JSON.parse_string(json_string)
	return parse_result
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		save_game_data(game_data_path, {"count_time":count_time})
	if what == Node.NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		save_game_data(game_data_path, {"count_time":count_time})
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var data = load_game_data(game_data_path)
	if data.has("count_time"):
		count_time = data["count_time"]
	update_time()


func _physics_process(_delta: float) -> void:
	update_time()

func _on_start_time_pressed() -> void:
	$Timer.paused = false
	$Timer.start()


func _on_pause_time_pressed() -> void:
	$Timer.paused = !$Timer.paused

func update_time()->void:
	var hours = count_time / 3600
	var minutes = count_time % 3600 / 60
	var secs = count_time % 60
	$Panel/VBoxContainer/CountTime.text = "%02d:%02d:%02d" % [hours, minutes, secs]
func _on_timer_timeout() -> void:
	count_time -= 1
	pass # Replace with function body.
