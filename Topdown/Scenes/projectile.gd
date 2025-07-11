extends Node2D
class_name Projectile

@export var flying_speed: int = 300
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var flying_direction: Vector2
var _is_boom: bool = false
func set_up(flying_direction: Vector2) -> void:
	self.flying_direction = flying_direction.normalized()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not _is_boom:
		global_position += flying_direction * flying_speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	_is_boom = true
	animated_sprite_2d.play("boom")
	await animated_sprite_2d.animation_finished
	queue_free()
