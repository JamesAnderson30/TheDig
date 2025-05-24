extends Node2D


var LevelHandler = preload("res://World/LevelHandler.tscn")
var levelHandler = LevelHandler.instantiate()



func _ready():
	var menuStart = levelHandler.loadLevel("mainMenu")
	add_child(menuStart)
	
