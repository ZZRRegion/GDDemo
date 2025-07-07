extends Control

var count_time = 60 * 60 * 24
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	update_time()

func _on_start_time_pressed() -> void:
	$Timer.start()
	print("开始")
	pass # Replace with function body.


func _on_pause_time_pressed() -> void:
	print("暂停")
	$Timer.paused = !$Timer.paused
	pass # Replace with function body.

func update_time()->void:
	var hours = int(count_time / 3600)
	var minutes = int((count_time % 3600) / 60)
	var secs = int(count_time % 60)
	$Panel/VBoxContainer/CountTime.text = "%02d:%02d:%02d" % [hours, minutes, secs]
func _on_timer_timeout() -> void:
	count_time -= 1
	pass # Replace with function body.
