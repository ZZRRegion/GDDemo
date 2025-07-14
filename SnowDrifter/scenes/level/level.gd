class_name Level
extends Node2D

const FENCE_HEIGHT = 32
const FLAG_SPACE = 50

const TREE_SPACE = 50
const TREE_SPACE_Y_MIN = 200
const TREE_SPACE_Y_MAX = 400
const TREE_DENSITY = 0.003

const COIN_SPACE = 80
const COIN_SPAWN_CHANCE = 0.5
const COIN_MIN_DISTANCE = 40

var course_width
var course_length
var endzone: EndZone
var noise

const fence_scn = preload("res://SnowDrifter/scenes/level/fence.tscn")
const flag_scn = preload("res://SnowDrifter/scenes/level/flag.tscn")
const endzone_scn = preload("res://SnowDrifter/scenes/level/endzone.tscn")
const tree_scn = preload("res://SnowDrifter/scenes/level/tree.tscn")
const coin_scn = preload("res://SnowDrifter/scenes/level/coin.tscn")

func _ready() -> void:
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
#创建关卡
func generate_level() -> void:
	course_width = get_viewport_rect().size.x
	course_length = 5000
	
	#生成内容
	_generate_fences()
	_generate_endzone()
	_generate_tree()
	_generate_coins()

#在赛道两侧生成栅栏
func _generate_fences() -> void:
	var current_height = 0
	var offset := -30
	while current_height < course_length:
		#在左侧放栅栏
		_add_fence_at(Vector2.LEFT * (course_width + offset) / 2.0 + Vector2.DOWN * current_height)
		#在右侧放栅栏
		_add_fence_at(Vector2.RIGHT * (course_width + offset) / 2.0 + Vector2.DOWN * current_height)
		
		current_height += FENCE_HEIGHT
		
#在赛道末端创建终点
func _generate_endzone() -> void:
	var new_endzone = endzone_scn.instantiate()
	
	#计算边界
	var top_left = Vector2(-course_width / 2.0, course_length)
	var bottom_right = top_left + Vector2(course_width, 100)
	
	new_endzone.set_corners(top_left, bottom_right)
	add_child(new_endzone)
	endzone = new_endzone
	
	#生成旗子
	var flag_x = -course_length / 2.0
	while flag_x < course_width / 2.0 - FLAG_SPACE:
		flag_x += FLAG_SPACE
		var flag_pos = Vector2(flag_x, top_left.y)
		_add_flag_at(flag_pos)

#随机生成树木
func _generate_tree() -> void:
	var last_y = 0
	while last_y + TREE_SPACE_Y_MAX < course_length:
		var tree_y = last_y + randf_range(TREE_SPACE_Y_MAX, TREE_SPACE_Y_MAX)
		last_y = tree_y
		
		#计算X坐标
		var tree_x_min = course_width / 2.0 - TREE_SPACE
		var tree_x = randf_range(-tree_x_min, tree_x_min)
		
		_add_tree_at(Vector2(tree_x, tree_y))

#使用噪声随机生成金币
func _generate_coins() -> void:
	#横向边界计算
	var x_start = -course_width / 2.0 + COIN_SPACE
	var x_end = course_width / 2.0 - COIN_SPACE
	
	#纵向边界计算
	var y_start = COIN_SPACE * 2
	var y_end = course_length - COIN_SPACE * 2
	
	#创建网格
	for x in range(x_start, x_end, COIN_SPACE):
		for y in range(y_start, y_end, COIN_SPACE * 2):
			#获取当前网格噪声值
			var noise_at_pos = noise.get_noise_2d(x, y)
			#归一化到0-1范围
			var normalized_noise = (noise_at_pos + 1.0) / 2.0
			#乘以基础概率得到生成概率
			var spawn_chance = normalized_noise * COIN_SPAWN_CHANCE
			
			if randf() < spawn_chance:
				var angle = randf() * TAU
				var distance = randf() * COIN_SPACE / 2.0
				var offset = Vector2.RIGHT.rotated(angle) * distance
				_add_coin_at(Vector2(x, y) + offset)
#放置栅栏
func _add_fence_at(pos):
	var new_fence = fence_scn.instantiate()
	new_fence.global_position = pos
	add_child(new_fence)
#放置旗子
func _add_flag_at(pos):
	var new_flag = flag_scn.instantiate()
	new_flag.global_position = pos
	add_child(new_flag)

#放置树木
func _add_tree_at(pos):
	var new_tree = tree_scn.instantiate()
	new_tree.global_position = pos
	add_child(new_tree)
	
#放置金币
func _add_coin_at(pos):
	var new_coin = coin_scn.instantiate()
	new_coin.global_position = pos
	add_child(new_coin)
	
	
	
	
