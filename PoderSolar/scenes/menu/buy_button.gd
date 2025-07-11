extends Button
@export var item_scene: PackedScene
@export var money_cost: int
@export var world: Node2D
@onready var label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var message: TextureRect = $Message
@export var prompt_nums: int = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message.hide()
	update_ui()
	button_down.connect(on_button_down)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	PSGamemanager.money_change.connect(on_money_change)
func on_mouse_entered() -> void:
	$Message/nums.text = str(prompt_nums)
	if prompt_nums >= 0:
		prompt_nums -= 1
		message.show()
func on_mouse_exited() -> void:
	message.hide()
func on_button_down() -> void:
	var item = item_scene.instantiate()
	world.add_child(item)

func update_ui() -> void:
	label.text = str(money_cost)
	disabled = PSGamemanager.money < money_cost
	if disabled:
		label.modulate = Color("989898")
	else:
		label.modulate = Color("c7fc76")
func on_money_change() -> void:
	update_ui()
