extends Node
const MONEY_DEFAULT: int = 1800
const ENERGY_DEFAULT: int = 36
const POLLUTION_DEFAULT: int = 0
const MAX_ENERGY: int = 50
const MAX_POLLUTION: int = 50
const CURRENT_LEVEL_DEFAULT: int = 0
signal start_level
signal money_change
signal pollution_change
signal  energy_change
# 放置区域限定
var appoint_rect: Rect2
var end_scene: PackedScene = load("res://PoderSolar/scenes/menu/end.tscn")
enum End_States {
	WIN,
	LOOSE_POLLUTION,
	LOOSE_ENERGY_OVERCHARGE,
	LOOSE_ENGERGY_OUT
}

var end_state: End_States
var current_level: int = CURRENT_LEVEL_DEFAULT
var money: int = MONEY_DEFAULT
var energy_mutex: Mutex = Mutex.new()
var energy: int = ENERGY_DEFAULT
var pollution: int = POLLUTION_DEFAULT

func run_game() -> void:
	Engine.time_scale = 1
	
func pause_game() -> void:
	Engine.time_scale = 0

func reset() -> void:
	current_level = CURRENT_LEVEL_DEFAULT
	money = MONEY_DEFAULT
	energy = ENERGY_DEFAULT
	pollution = POLLUTION_DEFAULT

func add_money(quantity: int) -> void:
	money += quantity
	money_change.emit()
	
func add_pollution(quantity: int) -> void:
	pollution += quantity
	print(Time.get_datetime_string_from_system() + "[]" + str(quantity))
	if pollution > MAX_POLLUTION:
		load_end_screen(End_States.LOOSE_POLLUTION)
	elif pollution < 0:
		pollution = POLLUTION_DEFAULT
	
	pollution_change.emit()
	
func add_energy(quantity: int) -> void:
	energy_mutex.lock()
	energy += quantity
	#print(Time.get_datetime_string_from_system() + str(quantity))
	energy_mutex.unlock()
	energy_change.emit()
	if energy > MAX_ENERGY:
		load_end_screen(End_States.LOOSE_ENERGY_OVERCHARGE)
	elif energy < 0:
		load_end_screen(End_States.LOOSE_ENGERGY_OUT)

func load_end_screen(_end_state: End_States):
	end_state = _end_state
	get_tree().change_scene_to_packed(end_scene)
	
	
	
