extends "res://Actors/player/statetemplate.gd"


var state_name = "Idling"

#enters state..
func enter():
	#player.velocity.x = 0
	player.animated_sprite.play("Idle")

#when it processes stuff..?
func physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		player.change_state("Run")
	elif Input.is_action_just_pressed("attack"):
		player.change_state("Attack")

func exit():
	pass
