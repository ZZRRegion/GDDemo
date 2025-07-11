extends Node
@onready var moon: Sprite2D = $Moon
@onready var slides: Control = $Slides
@onready var city: Node2D = $City

# 单位s
@export var GAME_TIME: int = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().title = "环保家"
	PSGamemanager.appoint_rect = $ColorRect.get_global_rect()
	PSGamemanager.start_level.connect(on_start_level)
	PSGamemanager.pause_game()
	if OS.is_debug_build():
		PSGamemanager.start_level.emit()
	else:
		load_slides(PSGamemanager.current_level)

func load_slides(level: int) ->void:
	slides.show()
	slides.load_slide(level, 0)
	
func on_start_level() -> void:
	PSGamemanager.run_game()
	city.setup_city()
	var moon_tw = create_tween()
	moon.position.x = 75.0
	moon_tw.tween_property(moon, "position:x", 750, GAME_TIME)
	await  moon_tw.finished
	PSGamemanager.pause_game()
	PSGamemanager.current_level += 1
	if PSGamemanager.current_level >= 3:
		PSGamemanager.load_end_screen(PSGamemanager.End_States.WIN)
	else:
		load_slides(PSGamemanager.current_level)
