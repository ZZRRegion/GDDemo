extends Node2D
class_name Projectile

@export var flying_speed: int = 300

var flying_direction: Vector2

func set_up(flying_direction: Vector2) -> void:
	self.flying_direction = flying_direction.normalized()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += flying_direction * flying_speed * delta
