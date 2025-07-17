extends Control
@onready var tab_container: TabContainer = $TabContainer
@onready var label_color: Label = $TabContainer/PanelContainer/VBoxContainer/HBoxContainer/LabelColor
@onready var color_picker_button: ColorPickerButton = $TabContainer/PanelContainer/VBoxContainer/HBoxContainer/ColorPickerButton
@onready var menu_button: MenuButton = $TabContainer/PanelContainer/VBoxContainer/HBoxContainer/MenuButton

var items_name := ["按钮"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_button.get_popup().id_pressed.connect(func (id):
		print(id)
		)
	label_color.text = "颜色：" + str(color_picker_button.color)
	for i in items_name.size():
		tab_container.set_tab_title(i, items_name[i])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_color_picker_button_color_changed(color: Color) -> void:
	label_color.text = "颜色：" + str(color)
	print(color)
	pass # Replace with function body.
