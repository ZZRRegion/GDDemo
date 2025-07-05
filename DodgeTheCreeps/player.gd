extends Area2D
signal hit
@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
	
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif  velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.stop()
	
	
func start(pos:Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(_body):
	hide()
	hit.emit()
	#敌人每次击中玩家时都会发出一个信号。要禁用玩家的碰撞检测，确保不会多次触发hit信号
	#set_deferred可以安全的禁用形状
	$CollisionShape2D.set_deferred(&"disabled", true)
	pass


func new_game() -> void:
	pass # Replace with function body.
