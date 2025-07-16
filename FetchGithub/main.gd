extends Control
@onready var tab_container: TabContainer = $TabContainer
@onready var animated_sprite_2d: AnimatedSprite2D = $Panel/AnimatedSprite2D
@onready var http_request: HTTPRequest = $HTTPRequest

var tab_items := ["客户端模式", "服务端模式", "关于"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var win := get_window()
	win.title = "Fetch Github Hosts-V2.8"
	for i in tab_items.size():
		tab_container.set_tab_title(i, tab_items[i])
	var url := "http://192.168.1.1/"
	url = "https://hosts.gitcdn.top/hosts.txt"
	var error := http_request.request(url)
	if error == OK:
		print("请求成功")
	else:
		print("请求错误")
	pass # Replace with function body.

func _on_animation_check_box_toggled(toggled_on: bool) -> void:
	animated_sprite_2d.visible = toggled_on
	pass # Replace with function body.


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("接收")
	print(result)
	print(body)
	print(headers)
