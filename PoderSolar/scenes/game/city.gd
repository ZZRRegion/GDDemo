extends Node2D
@onready var icons: Node2D = $Icons
@onready var money_up: Sprite2D = $Icons/MoneyUp
@onready var pollution_up: Sprite2D = $Icons/PollutionUp
@onready var energy_down: Sprite2D = $Icons/EnergyDown
@onready var money_anim: AnimationPlayer = $Icons/MoneyUp/AnimationPlayer
@onready var pollution_anim: AnimationPlayer = $Icons/PollutionUp/AnimationPlayer
@onready var energy_anim: AnimationPlayer = $Icons/EnergyDown/AnimationPlayer
@onready var timer: Timer = $Timer
@onready var concert_light: Sprite2D = $ConcertLight
@onready var pollution: Sprite2D = $Pollution
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var is_pollution: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(on_timeout)
	setup_city()
	timer.start()
func on_timeout() -> void:
	add_money()
	add_energy()
	if is_pollution:
		add_pollution()

func add_money() -> void:
	money_up.show()
	money_anim.play("gather")
func add_energy() -> void:
	energy_down.show()
	energy_anim.play("gather")
func add_pollution() -> void:
	pollution_up.show()
	pollution_anim.play("gather")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setup_city() -> void:
	match PSGamemanager.current_level:
		0:
			is_pollution = false
			timer.set_wait_time(1.0)
			icons.show()
			concert_light.hide()
			pollution.hide()
		1:
			is_pollution = false
			timer.set_wait_time(0.5)
			concert_light.show()
			pollution.hide()
		2:
			is_pollution = true
			timer.set_wait_time(0.4)
			concert_light.hide()
			pollution.show()
