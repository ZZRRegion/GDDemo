class_name EndZone
extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@export var debug_color: = Color(0, 1, 0, 0.3)
@export var debug_draw := true
var _rect := Rect2()

#设置矩形区域的个对角点
func set_corners(p1: Vector2, p2: Vector2) -> void:
	var position = Vector2(min(p1.x, p2.x), min(p1.y, p2.y))
	var size = Vector2(abs(p1.x - p2.x), abs(p1.y - p2.y))
	_rect = Rect2(position, size)
	_update_shape()
#更新碰撞体
func _update_shape() -> void:
	if collision and collision.shape:
		collision.shape.size = _rect.size
		collision.position = _rect.position + _rect.size / 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.shape = RectangleShape2D.new()
	_update_shape()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	if debug_draw:
		draw_rect(_rect, debug_color, true)
		draw_rect(_rect, debug_color.darkened(0.3), false, 2.0)
