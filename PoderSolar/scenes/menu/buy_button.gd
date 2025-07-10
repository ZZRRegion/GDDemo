extends Button
@export var item_scene: PackedScene
@export var money_cost: int
@export var world: Node2D
@onready var label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Label
@onready var message: TextureRect = $Message

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	message.hide()
	update_ui()
	button_down.connect(on_button_down)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func on_mouse_entered() -> void:
	message.show()
func on_mouse_exited() -> void:
	message.hide()
func on_button_down() -> void:
	var item = item_scene.instantiate()
	world.add_child(item)

func update_ui() -> void:
	label.text = str(money_cost)
