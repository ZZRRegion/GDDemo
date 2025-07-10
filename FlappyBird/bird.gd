extends CharacterBody2D


const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("fly"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()
