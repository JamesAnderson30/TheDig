extends "res://Actors/player/statetemplate.gd"

var state_name = "Attacking"


func enter():
	player.velocity.x = 0
	player.animated_sprite.play("Attack")
	await player.animated_sprite.animation_finished
	player.change_state("Idle")
	
func process_input(event):
	pass

func exit():
	pass

func physics_process(_delta):
#	This function must always return a string. 
#	Pass the state_name of the new state you want the player to enter
#	If you want to stay in the same state, return ""
	return ""
	pass
