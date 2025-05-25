extends Node

@onready var new_game_menu = $NewGameMenu
@onready var top_level_menu = $TopLevelMenu

func _ready():
	new_game_menu.hide()
	$TopLevelMenu/VBoxContainer/Start.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	pass

	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.is_action_pressed("ui_cancel"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

func _on_start_pressed():
	top_level_menu.hide()
	new_game_menu.show()
	$NewGameMenu/VBoxContainer/NewGame.grab_focus()
	pass

func _on_settings_pressed():
	pass #no settings yet, so 

func _on_quit_pressed():
	get_tree() .quit() 


func _on_new_game_pressed():
	LevelHandler.loadLevel("testLevel")
	pass # Replace with function body.
	


func _on_load_game_pressed():
	pass # Replace with function body.
	

func _on_reload_last_save_pressed():
	pass # Replace with function body.



func _on_back_pressed():
	new_game_menu.hide()
	top_level_menu.show()
	$TopLevelMenu/VBoxContainer/Start.grab_focus()
	pass
	
