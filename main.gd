@tool
extends Node2D
#region
# sfsfaf
#endregion
## 这是设置的值
## 这是个很好的例子
@export var myValue:int = 110

func _process(delta: float) -> void:
	queue_redraw()
