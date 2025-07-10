extends Control
@onready var button: Button = $Button

func _ready() -> void:
	button.pressed.connect(my_test.bind($A.name))

func my_test(v):
	print(v)
