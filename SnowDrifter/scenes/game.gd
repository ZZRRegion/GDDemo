extends Node2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: SDPlayer = $Player
static var current_score := 0
const level_scn = preload("res://SnowDrifter/scenes/level/level.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_game()


func init_game() -> void:
	var level = level_scn.instantiate()
	add_child(level)
	level.generate_level()
	level.endzone.body_entered.connect(_on_endzone_entered)
	
	current_score = 0

#终点检测回调
func _on_endzone_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("比赛结束:玩家名", body.name)
		
func _on_coin_collected() -> void:
	current_score += 1
	print("当前积分：", current_score)
