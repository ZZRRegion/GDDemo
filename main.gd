extends Node2D
func _unhandled_input(event: InputEvent) -> void:
	pass
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var d:Dictionary = {"hello":"dsf", "dsf":23}
	print(d)
	var a:Array = ["fsf", 234, "fsaf"]
	print(a)
	var c:PackedStringArray = ["fsf", 23424]
	print(c)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
