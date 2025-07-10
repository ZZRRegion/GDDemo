extends CanvasLayer
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var message: Label = $MarginContainer/VBoxContainer/Message
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	update_score()
	GameManager.GetScore.connect(update_score)
	GameManager.GameOver.connect(on_game_over)
	
func on_game_over()->void:
	message.text = "GAME OVER"
	message.show()
	timer.start()

func update_score()->void:
	score_label.text = "Score:%s" %str(GameManager.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		GameManager.restart()


func _on_timer_timeout() -> void:
	message.text = "Click Mouse to Restart"
	set_process(true)
