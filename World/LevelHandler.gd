extends Node



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
	print("Level handler recieved call..")
	var levelScene = level_list[level_id]["scene"].instantiate()
	
	return levelScene
	push_error("failed on loadLevel, could not find level ID in level list", % level_id)
