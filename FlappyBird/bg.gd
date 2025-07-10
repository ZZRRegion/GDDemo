extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.GameOver.connect(on_game_over)
	pass # Replace with function body.

func on_game_over()->void:
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x += GameManager.SPEED * delta
	
	
	
	
	
	
	
	
	
	
	
	
	
	
