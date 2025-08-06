extends Area2D
@export var slime_speed: float = -100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound: AudioStreamPlayer = $DeathSound

var is_dead: bool = false
func _physics_process(delta: float) -> void:
	if not is_dead:
		position += Vector2(slime_speed, 0) * delta
	if position.x < -267:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_dead:
		body.game_over()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		area.queue_free()
		animated_sprite_2d.play("death")
		death_sound.play()
		get_tree().current_scene.score += 1
		is_dead = true
		await get_tree().create_timer(0.6).timeout
		queue_free()
