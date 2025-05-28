extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame  # Let the scene fully load
	LevelHandler.connect("level_changed", _on_level_changed)
#	PRE-SORTING
#	We will pre-sort all of our NPC's into all kinds of differnt lists for fast look up
#   When we want to launch this game, we will run this script and store the results in a file
#	and load it up then.
#   For now we just do this.

#	If you want to add an NPC, just add it to the NPC dictionary and yadayada

#PRE-SORTING
#	SORTING NPC'S INTO ENEMIES
	for npcKey in npcDictionary.keys():
		enemyDictionary[npcKey] = npcDictionary[npcKey]
			
#	SORTING ENEMIES INTO ENEMY BY FACTION
	for enemy in enemyDictionary.keys():
		if (enemyByFaction.has(enemyDictionary[enemy]["faction"])):
			enemyByFaction[enemyDictionary[enemy]["faction"]].append(enemyDictionary[enemy])
		else:
			enemyByFaction[enemyDictionary[enemy]["faction"]] = [enemyDictionary[enemy]]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_changed():
	print("The level has changed!")
	
func getById(id):
	if(npcDictionary.has(id)):
		return load(npcDictionary[id]["scene"]).instantiate()
	else:
		print("Could not find NPC: ", id)
		return null

var npcDictionary = {
	"TestEnemy": {
		"scene": "res://Actors/enemy/fruits/testFruitEnemy.tscn",
		"faction": "fruit",
		"class": "small",
		"disposition": "enemy"
	}
}

var enemyDictionary = {}

var enemyByFaction = {}
