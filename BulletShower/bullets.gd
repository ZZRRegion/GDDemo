extends Node2D

const BULLET_COUNT = 500
const SPEED_MIN = 20
const SPEED_MAX = 80

const bullet_image = preload("res://BulletShower/bullet.png")

var bullets = []
var shape:RID = RID()
class Bullet:
	var position:Vector2 = Vector2()
	var speed:float = 1.0
	var body:RID = RID()
	func _test()->void:
		print("s")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(shape, 8)
	
	for _i in BULLET_COUNT:
		var bullet:Bullet = Bullet.new()
		bullet.speed = randf_range(SPEED_MIN, SPEED_MAX)
		bullet.body = PhysicsServer2D.body_create()
		
		PhysicsServer2D.body_set_space(bullet.body, get_world_2d().get_space())
		PhysicsServer2D.body_add_shape(bullet.body, shape)
		PhysicsServer2D.body_set_collision_mask(bullet.body, 0)
		
		bullet.position = Vector2(
			randf_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			randf_range(0, get_viewport_rect().size.y)
		)
		var transform2d := Transform2D()
		transform2d.origin = bullet.position
		PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)
		bullets.push_back(bullet)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
func _physics_process(delta: float) -> void:
	var transform2d := Transform2D()
	var offset := get_viewport_rect().size.x + 16
	for bullet: Bullet in bullets:
		bullet.position.x -= bullet.speed * delta

		if bullet.position.x < -16:
			# Move the bullet back to the right when it left the screen.
			bullet.position.x = offset

		transform2d.origin = bullet.position
		PhysicsServer2D.body_set_state(bullet.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)
	
	
func _draw() -> void:
	var offset := -bullet_image.get_size() * 0.5
	for bullet: Bullet in bullets:
		draw_texture(bullet_image, bullet.position + offset)


# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree() -> void:
	for bullet: Bullet in bullets:
		PhysicsServer2D.free_rid(bullet.body)

	PhysicsServer2D.free_rid(shape)
	bullets.clear()
	
	
	
	
	
	
	
	
	
	
	
