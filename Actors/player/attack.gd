extends "res://Actors/player/statetemplate.gd"

var state_name = "Attacking"

func enter():
	player.velocity.x = 0
	player.animated_sprite.play("Attack")
	await player.animated_sprite.animation_finished
	player.change_state("Idle")

func exit():
	pass

func physics_process(_delta):
	pass
