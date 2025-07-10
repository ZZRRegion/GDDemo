extends Node

signal start_level
signal money_change
signal pollution_change
signal  energy_change

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
