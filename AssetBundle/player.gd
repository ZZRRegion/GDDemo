extends CharacterBody2D

@export var speed: float = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vec: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = vec * speed
	move_and_slide()
