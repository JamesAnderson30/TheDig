extends "res://Actors/player/statetemplate.gd"

var state_name = "Idling"

# Big Note to my precious Auri, if you need to make things
# Happen to the player, the player node is called "player"
#enters state..
func enter():
	#player.velocity.x = 0
	player.animated_sprite.play("Idle")
	
func process_input(event):
	if(event.is_action_pressed("space")):
		return "Jumping"
	pass

#when it processes stuff..?
func physics_process(delta):
#	Gravity:
#	If not on floor, make fall
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
#	If on floor, stop moving
	else:
		player.velocity.x = 0
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		return("Running")
		#player.change_state("Run")
	elif Input.is_action_just_pressed("attack"):
		return("Attacking")
		#player.change_state("Attack")
	return ""

func exit():
	pass
