extends Node

signal level_changed

var root_scene = null

func init(mainRoot):
	root_scene = mainRoot
	print("Root Scene is: ", root_scene)
	if(!root_scene):
		print("LevelHandler cannot find main.gd")

var level_list = {
	# adding main menu to list, and defining "id" to use in first thing
	"mainMenu" : {
		"name": "Main Menu",
		"scene": preload("res://World/Menus/MainMenu.tscn")
	},
	
	"testLevel" : {
		"name" : "Test Level",
		"scene": preload("res://World/LevelList/0LevelZero/TestLevel.tscn")
	},
	
	"levelOne" : {
		"name": "Home Sweet.. home?",
		"scene": preload("res://World/LevelList/1LevelOne/HmStHm.tscn")
	},
}

func _ready():
	pass
	
	
func loadLevel(level_id):
	print("Level handler recieved call: ", level_id)
#	First, clean the root scene
	for child in root_scene.get_children():
		child.queue_free()
	
	var levelScene = level_list[level_id]["scene"].instantiate()
	print("LevelScene is : ", levelScene)
	
	if(!levelScene):
		push_error("failed on loadLevel, could not find level ID in level list", % level_id)
	else:
		root_scene.add_child(levelScene)
	
