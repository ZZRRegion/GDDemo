extends Node
@onready var moon: Sprite2D = $Moon
@onready var slides: Control = $Slides



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PSGamemanager.start_level.connect(on_start_level)
	PSGamemanager.pause_game()
	load_slides(PSGamemanager.current_level)

func load_slides(level: int) ->void:
	slides.show()
	slides.load_slide(level, 0)
	
func on_start_level() -> void:
	PSGamemanager.run_game()
	var moon_tw = create_tween()
	moon.position.x = 75.0
	moon_tw.tween_property(moon, "position:x", 750, 60)
	await  moon_tw.finished
	PSGamemanager.pause_game()
	PSGamemanager.current_level += 1
	load_slides(PSGamemanager.current_level)
