extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().title = "时间"
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var t = Time.get_time_string_from_system()
	$CurTime.text = t
	pass
