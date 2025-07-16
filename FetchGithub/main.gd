extends Control
@onready var tab_container: TabContainer = $TabContainer
var tab_items := ["客户端模式", "服务端模式", "关于"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var win := get_window()
	win.title = "Fetch Github Hosts-V2.8"
	for i in tab_items.size():
		tab_container.set_tab_title(i, tab_items[i])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
