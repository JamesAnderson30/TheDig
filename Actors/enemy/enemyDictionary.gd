extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for enemy in enemyDictionary.keys():
		print(enemyDictionary)
		print(enemy)
		if (enemyByFaction.has(enemyDictionary[enemy]["faction"])):
			enemyByFaction[enemyDictionary[enemy]["faction"]].append(enemyDictionary[enemy])
		else:
			enemyByFaction[enemyDictionary[enemy]["faction"]] = [enemyDictionary[enemy]]
	print(enemyByFaction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var enemyDictionary = {
	"TestEnemy": {
		"scene": "res://Actors/enemy/fruits/testFruitEnemy.tscn",
		"faction": "fruit",
		"class": "small"
	}
}


var enemyByFaction = {}
