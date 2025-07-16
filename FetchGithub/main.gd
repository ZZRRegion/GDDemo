extends Control
@onready var tab_container: TabContainer = $TabContainer
@onready var animated_sprite_2d: AnimatedSprite2D = $Panel/AnimatedSprite2D

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


func _on_animation_check_box_toggled(toggled_on: bool) -> void:
	animated_sprite_2d.visible = toggled_on
	pass # Replace with function body.
