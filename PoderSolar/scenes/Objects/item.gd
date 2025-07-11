extends Node2D

@export var cost: int
@export var sell_price: int
@export var money: int
@export var energy: int
@export var pollution: int
@onready var audio: AudioStreamPlayer = $Audio
@onready var audio_sell: AudioStreamPlayer = $Audio2
@onready var money_label: Label = $SellButton/MoneyLabel
@onready var sell_button: Button = $SellButton
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: Control = $HitBox

var is_hovering: bool = false
var is_instantiated: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money_label.text = str(sell_price)
	sell_button.hide()
	timer.timeout.connect(on_timeout)
	hit_box.mouse_entered.connect(on_mouse_entered)
	sell_button.mouse_exited.connect(on_mouse_exited)
	sell_button.pressed.connect(on_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_instantiated:
		global_position = get_global_mouse_position()
		if not can_placed():
			self.modulate = Color.RED
			$Message.show()
		else:
			modulate = Color.WHITE
			$Message.hide()
	elif is_hovering:
		if not hit_box.get_global_rect().has_point(get_global_mouse_position()):
			sell_button.mouse_exited.emit()
			
	
func can_placed() -> bool:
	return PSGamemanager.appoint_rect.has_point(get_global_mouse_position())
func _input(event: InputEvent) -> void:
	if event.is_action_released("click") and not is_instantiated and can_placed():
		is_instantiated = true
		audio.play()
		timer.start()
		PSGamemanager.add_money(-cost)
		animation_player.play("on_placed")
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed and not is_instantiated and not can_placed():
				queue_free()
		
func on_timeout() -> void:
	animation_player.play("on_gathered")
	on_resource_gathered(money, energy, pollution)
func on_mouse_entered() -> void:
	is_hovering = true
	if is_instantiated:
		sell_button.visible = true
	
func on_mouse_exited() -> void:
	if is_hovering:
		is_hovering = false
		sell_button.visible = false
	
func on_pressed() ->void:
	audio_sell.play()
	timer.stop()
	on_sell(sell_price)
	sell_button.hide()
	animation_player.play("on_sell")
	await  animation_player.animation_finished
	queue_free()
	
func on_sell(money: int) -> void:
	PSGamemanager.add_money(money)
	
func on_resource_gathered(money, energy, pollution):
	PSGamemanager.add_money(money)
	PSGamemanager.add_energy(energy)
	PSGamemanager.add_pollution(pollution)

	
	
	
