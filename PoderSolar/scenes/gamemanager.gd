extends Node

signal start_level
signal money_change
signal pollution_change
signal  energy_change

var end_scene: PackedScene = load("res://PoderSolar/scenes/menu/end.tscn")
enum End_States {
	WIN,
	LOOSE_POLLUTION,
	LOOSE_ENERGY_OVERCHARGE,
	LOOSE_ENGERGY_OUT
}

var end_state: End_States
var current_level: int = 0
var money: int = 300
var max_energy: int = 50
var max_pollution: int = 50
var energy: int = 25
var pollution: int = 0

func run_game() -> void:
	Engine.time_scale = 1
	
func pause_game() -> void:
	Engine.time_scale = 0

func reset() -> void:
	current_level = 0
	money = 300
	energy = 25
	pollution = 0

func add_money(quantity: int) -> void:
	money += quantity
	money_change.emit()
	
func add_pollution(quantity: int) -> void:
	pollution += quantity
	if pollution > max_pollution:
		load_end_screen(End_States.LOOSE_POLLUTION)
	elif pollution < 0:
		pollution = 0
	
	pollution_change.emit()
	
func add_energy(quantity: int) -> void:
	energy += quantity
	energy_change.emit()
	if energy > max_energy:
		load_end_screen(End_States.LOOSE_ENERGY_OVERCHARGE)
	elif energy < 0:
		load_end_screen(End_States.LOOSE_ENGERGY_OUT)

func load_end_screen(_end_state: End_States):
	end_state = _end_state
	get_tree().change_scene_to_packed(end_scene)
	
	
	
