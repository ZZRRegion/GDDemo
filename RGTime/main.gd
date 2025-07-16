extends Control
@onready var cur_time: Label = $MarginContainer/VBoxContainer/CurTime
const scale_num: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var win := get_window()
	win.title = "时间"
	win.size /= scale_num
	self.scale = Vector2(scale_num, scale_num)
	var screen_size := DisplayServer.screen_get_size()
	win.position = (screen_size - win.size) / 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cur_time.text = Time.get_time_string_from_system()
	pass


func _on_check_box_toggled(toggled_on: bool) -> void:
	get_window().always_on_top = toggled_on
	pass # Replace with function body.
