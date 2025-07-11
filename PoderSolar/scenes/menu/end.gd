extends Control
@onready var image: TextureRect = $Image
@onready var title: Label = $Title
@onready var desc: Label = $Desc
@onready var button: Button = $Button

@export var menu_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state(PSGamemanager.end_state)
	button.pressed.connect(on_pressed)
	
func set_state(state: PSGamemanager.End_States) -> void:
	match state:
		PSGamemanager.End_States.WIN:
			title.text = "胜利"
			desc.text = "你赢了"
			image.texture = load("res://PoderSolar/assets/sprites/slides/win.jpg")
		PSGamemanager.End_States.LOOSE_ENERGY_OVERCHARGE:
			title.text = "过载了"
			desc.text = "太多能源了"
			image.texture = load("res://PoderSolar/assets/sprites/slides/fire.jpg")
		PSGamemanager.End_States.LOOSE_ENGERGY_OUT:
			title.text = "枯竭了"
			desc.text = "。。。"
			image.texture = load("res://PoderSolar/assets/sprites/slides/lights_out.jpg")
		PSGamemanager.End_States.LOOSE_POLLUTION:
			title.text = "Pollution!"
			desc.text = "So much pollution has caused an ecological"
			image.texture = load("res://PoderSolar/assets/sprites/slides/pollution.jpg")
func on_pressed() -> void:
	get_tree().change_scene_to_packed(menu_scene)
