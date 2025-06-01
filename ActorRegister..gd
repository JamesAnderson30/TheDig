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

func getOneNodeByName(name):
	if(npcRegistry.has(name)):
		return npcRegistry[name][0].node
	else:
		return null

func getNewInstanceByName(name):
	if(npcDictionary.has(name)):
		var dictionaryEntry = npcDictionary[name]
		var newNPC = load(dictionaryEntry["scene"]).instantiate()
		registerNPC(newNPC, dictionaryEntry)
		return newNPC
	else:
		print("Could not find NPC: ", name)
		return null
		
func registerNPC(NPC: Node2D, entry: Dictionary):
	entry["node"] = NPC
	if(npcRegistry.has(entry["name"])):
		npcRegistry[entry["name"]].append(entry)
	else:
		npcRegistry[entry["name"]] = [entry]
		
var npcRegistry = {}

func getEntryByName(name):
	if(npcDictionary.has(name)):
		return npcDictionary[name]
	else:
		print("No NPC by that name exists!")
		return null

func dumpNpcRegistry():
	print("NPC Registry: ", npcRegistry)

var npcDictionary = {
	"Player": {
		"name": "Player",
		"scene": "res://Actors/player/player.tscn",
		"faction": "dig",
		"class": "player",
		"disposition": "player"
	},
#	ENEMIES HERE
	"TestEnemy": {
		"name": "TestEnemy",
		"scene": "res://Actors/enemy/fruits/testFruitEnemy/testFruitEnemy.tscn",
		"faction": "fruit",
		"class": "small",
		"disposition": "enemy"
	}
}

var enemyDictionary = {}

var enemyByFaction = {}
