extends Control

const game_slides = {
	0:{
		0:{
			"text": "They have installed [b]solar panels[/b] in the town!",
			"image": "res://PoderSolar/assets/sprites/slides/win.jpg"
		},
		1:{
			"text": "But when [b]night falls[/b] we run out of electricity :(",
			"image":"res://PoderSolar/assets/sprites/slides/lights_out.jpg"
		},
		2:{
			"text": "[b]Drag[/b] objects to the screen to buy them",
			"image":"res://PoderSolar/assets/sprites/slides/lights_out.jpg"
		},
		3:{
			"text": "Don't run out of [b]electricity[/b] or there will be a blackout",
			"image":"res://PoderSolar/assets/sprites/slides/tutorial_lowenergy.jpg"
		},
		4:{
			"text": "But don't overdo it, too much electricity will cause an [b]overload[/b]",
			"image":"res://PoderSolar/assets/sprites/slides/tutorial_lowenergy.jpg"
		},
		5:{
			"text": "Finally, don't let [b]pollution[/b] rise or there will be an ecological disaster",
			"image":"res://PoderSolar/assets/sprites/slides/tutorial_lowenergy.jpg"
		}
	},
	1:{
		0:{
			"text": "Today they are giving a concert. This will [b]increase[/b] electricity consumption!",
			"image":"res://PoderSolar/assets/sprites/slides/tutorial_lowenergy.jpg"
		}
	},
	2:{
		0:{
			"text": "Someone farted and now the town generates a lot of [b]pollution[/b]",
			"image":"res://PoderSolar/assets/sprites/slides/pollution_slide.jpg"
		}
	}
}
@onready var texture_rect: TextureRect = $TextureRect
@onready var button: Button = $Button
@onready var rich_text_label: RichTextLabel = $Panel/RichTextLabel

var current_slide: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(on_pressed)

func on_pressed() -> void:
	load_next_slide()
	
func load_next_slide() ->void:
	current_slide += 1
	if current_slide < game_slides[PSGamemanager.current_level].size():
		load_slide(PSGamemanager.current_level, current_slide)
	else:
		hide()
		PSGamemanager.start_level.emit()
func load_slide(level: int, slide: int) ->void:
	texture_rect.texture = load(game_slides[level][slide].image)
	rich_text_label.text = game_slides[level][slide].text
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
