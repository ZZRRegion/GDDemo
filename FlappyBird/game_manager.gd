extends Node

signal GameOver
signal GetScore

const SPEED = -150
const JUMP_VELOCITY = -500.0
const GRAVITY = 1500
var score :int = 0

func _ready() -> void:
	GetScore.connect(add_score)
	
func add_score() -> void:
	score += 1
