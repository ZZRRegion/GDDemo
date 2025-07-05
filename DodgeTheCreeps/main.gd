extends Node

@export var mob_scene:PackedScene
var score:int = 0
var nums:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	nums = get_tree().get_nodes_in_group("mobs").size()
	self.update_data()


func game_over() -> void:
	$Music.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
func restart() -> void:
	score = 0
	nums = 0
	update_data()
	clear_mob()
func update_data() -> void:
	$HUD.update_nums(nums)
	$HUD.update_score(score)
func clear_mob():
	get_tree().call_group("mobs", "queue_free")

func new_game():
	restart()
	$HUD.show_message("Get Ready")
	$Music.play()
	$StartTimer.start()

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$Player.start($StartPosition.position)

func _on_score_timer_timeout() -> void:
	score += 1

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	mob.add_to_group("mobs")
	add_child(mob)
	
