extends Node

signal GameOver
signal GetScore

const SPEED = -150
const JUMP_VELOCITY = -500.0
const GRAVITY = 1500
var score :int = 0

var game_scene : PackedScene = preload("res://FlappyBird/game.tscn")
func _ready() -> void:
	GetScore.connect(add_score)
	
func add_score() -> void:
	score += 1

func restart() ->void:
	score = 0
	get_tree().change_scene_to_packed(game_scene)
	
	
	
	
	
	
