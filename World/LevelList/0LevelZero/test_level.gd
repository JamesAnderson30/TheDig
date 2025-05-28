extends Node2D

# Need enemy and player on readys.. 
# Level going to handle all in-level logic. 

# initSpawn
var initSpawn = [
		{"id": "TestEnemy", "x": 270, "y": 98},
		{"id": "TestEnemy", "x": 320, "y": 114}
	]
func _ready():
	for spawn in initSpawn:
		var newSpawn = ActorRegister.getById(spawn.id)
		print("trying to spawn: ", newSpawn)
		if(newSpawn):
			newSpawn.position = Vector2(spawn.x, spawn.y)
			add_child(newSpawn)
	pass
	
