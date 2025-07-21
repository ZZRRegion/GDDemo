extends Control
@onready var tab_container: TabContainer = $TabContainer

var items_text := ["应用程序", "录像机", "编辑器", "自动化任务", "键盘快捷键", "语言", "临时文件", "上传服务", "附加功能", "捐赠", "关于"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in tab_container.get_tab_count():
		tab_container.set_tab_title(i, items_text[i])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
