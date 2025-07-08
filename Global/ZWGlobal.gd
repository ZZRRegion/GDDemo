extends Node
@export var nameTxt : String = "zw"
@export var age : int = 20
var file_path :String = "user://demo.json"
func to_dict() -> Dictionary:
	return {
		"nameTxt": nameTxt,
		"age" : age,
		"file_path": file_path,
		"last_time" : Time.get_datetime_string_from_system()
	}
func _ready() -> void:
	load_data()
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_WM_CLOSE_REQUEST:
		save()
		
func load_data() -> void:
	if !FileAccess.file_exists(file_path):
		return
	var content := FileAccess.get_file_as_string(file_path)
	print(content)
	
func save() -> void:
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	var dict = to_dict()
	var content := JSON.stringify(dict)
	file.store_string(content)
	file.close()
