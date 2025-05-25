extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame  # Let the scene fully load
	LevelHandler.connect("level_changed", _on_level_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_changed():
	print("The level has changed!")
