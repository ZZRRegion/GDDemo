extends CharacterBody2D

@export var maxspeed : float = 200
@export var accel : float = 150
@export var fricition : float = 75

var input : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()
	
func movement(delta : float) -> void:
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if input.length() == 0:
		if velocity.length() > fricition * delta:
			velocity -= velocity.normalized()
		else:
			velocity = Vector2.ZERO
	else:
		velocity += input * accel * delta
		velocity = velocity.limit_length(maxspeed)
