extends Node2D

# LevelHandler is now a global scene so you do not need to load it
# to use it anymore



func _ready():
#	I am passing main.gd's reference to LevelHandler
#   This will allow level handler to clean main and reload new levels onto it
#	Therefore, it's very important that the game gives control to LevelHandler
	LevelHandler.init(self)
	
	LevelHandler.loadLevel("mainMenu")
	
